import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:neds/App/Models/Main/AutisticPatient.dart';
import 'package:neds/App/Models/Main/CategoryItem.dart';
import 'package:neds/App/Modules/Dashboard/binding/dashboard_binding.dart';
import 'package:neds/App/Modules/Dashboard/view/dashboard_view.dart';
import 'package:neds/App/Utilities/Constants/AppColors.dart';
import 'package:path/path.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neds/App/Services/AuthenticationService/Core/manager.dart';
import 'package:neds/App/Utilities/painters/label_detector_painter.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;

import 'package:speech_to_text/speech_to_text.dart';

class AddCategoryFromLocalController extends GetxController {
  final AuthenticationManager authManager = Get.find();
  Rx<AutisticPatient> currentChild = AutisticPatient().obs;
  final TextEditingController realNameController = TextEditingController();
  XFile image = XFile('');
  late ImageLabeler imageLabeler;
  bool canProcess = false;
  bool isBusy = false;
  CustomPaint? customPaint;
  RxList<String> imageLabels = <String>[].obs;
  RxBool selected = false.obs,
      firstDataEntered = false.obs,
      sccaned = false.obs;
  Rx<CategoryItem> categoryItem = CategoryItem().obs;
  SpeechToText? speechToText;
  RxBool isListening = false.obs;
  RxString text = ''.obs;
  RxDouble confidence = (1.0).obs;

  @override
  Future<void> onInit() async {
    initializeLabeler();
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    currentChild.value = authManager.getCurrentChild();
    categoryItem.value = CategoryItem(
      apId: currentChild.value.id,
      type: 100,
    );
    super.onReady();
  }

  @override
  Future<void> onClose() async {
    canProcess = false;
    imageLabeler.close();
    super.onClose();
  }

  Future getImage() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image
    image = await picker.pickImage(source: ImageSource.gallery) ?? XFile('');
    if (image.path != '') {
      selected.value = true;
    } else {
      image = XFile('');
      selected.value = false;
    }
  }

  void initializeLabeler() async {
    const path = 'assets/ml/object_labeler.tflite';
    final modelPath = await _getModel(path);
    final options = LocalLabelerOptions(modelPath: modelPath);
    imageLabeler = ImageLabeler(options: options);
    canProcess = true;
    speechToText = SpeechToText();
  }

  Future<String> _getModel(String assetPath) async {
    if (io.Platform.isAndroid) {
      return 'flutter_assets/$assetPath';
    }
    final path = '${(await getApplicationSupportDirectory()).path}/$assetPath';
    await io.Directory(dirname(path)).create(recursive: true);
    final file = io.File(path);
    if (!await file.exists()) {
      final byteData = await rootBundle.load(assetPath);
      await file.writeAsBytes(byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    }
    return file.path;
  }

  Future<void> processImage() async {
    final inputImage = InputImage.fromFilePath(image.path);
    if (!canProcess) return;
    if (isBusy) return;
    isBusy = true;
    imageLabels.clear();
    sccaned.value = true;

    final labels = await imageLabeler.processImage(inputImage);
    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      final painter = LabelDetectorPainter(labels);
      customPaint = CustomPaint(painter: painter);
    } else {
      //  String text = 'Labels found: ${labels.length}\n\n';
      for (final label in labels) {
        print(labels.length);
        imageLabels.add(label.label);
      }
      customPaint = null;
    }
    isBusy = false;
    // if (mounted) {
    //   setState(() {});
    // }
  }

  void listen(BuildContext context) async {
    if (!isListening.value) {
      bool available = await speechToText!.initialize(
          onStatus: (val) => print('onStatus: $val'),
          onError: (val) => authManager.commonTools.showWarningSnackBar(
              'Sorry, we can\'t detect the word, please try again!'));
      if (available) {
        text.value = '';

        isListening.value = true;
        speechToText!
            .listen(
                onResult: (val) {
                  print(val.toJson());
                  text.value = val.recognizedWords;

                  if (val.hasConfidenceRating && val.confidence > 0) {
                    confidence.value = val.confidence;
                  }
                },
                cancelOnError: true,
                listenFor: Duration(seconds: 3))
            .whenComplete(
                () => Future.delayed(Duration(milliseconds: 3800), () {
                      if (text.value.isNotEmpty) {
                        authManager.commonTools.ShowWarningDialogMutliButtons(
                            context,
                            'Result',
                            'The result it\'s "${text.value}", do you want set it?',
                            'Yes',
                            'No',
                            AppColors.blue,
                            AppColors.failed, () async {
                          Get.back();
                          addImageToCategories(text.value);

                          authManager.commonTools.showSuccessSnackBar(
                              'The image has been added to ${currentChild.value.name}\'s Dictionary successfully');
                        }, () {
                          Get.back();
                        });
                      } else {
                        authManager.commonTools.showWarningSnackBar(
                            'Sorry, we can\'t detect the word, please try again!');
                      }
                    }));
      }
    } else {
      isListening.value = false;
      speechToText!.stop();
    }
  }

  Future<void> addImageToCategories(String nickName) async {
    categoryItem.value.nickName = nickName;
    var data = authManager.storage.read('localSelectedCategories');

    List<dynamic> temp = data == null ? [] : jsonDecode(data);

    List<CategoryItem> localSelectedCategories = temp.isEmpty
        ? []
        : temp.map<CategoryItem>((jsonItem) {
            return CategoryItem.fromJson(jsonItem);
          }).toList();

    localSelectedCategories.add(categoryItem.value);
    print(categoryItem.value.toJson());
    await authManager.storage
        .write('localSelectedCategories', jsonEncode(localSelectedCategories));
    Get.offAll(() => DashboardView(), binding: DashboardBinding());
  }
}
