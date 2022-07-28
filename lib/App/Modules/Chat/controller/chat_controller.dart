import 'dart:convert';

import 'package:get/get.dart';
import 'package:neds/App/Models/Main/FeelingCount.dart';
import 'package:neds/App/Services/AuthenticationService/Core/manager.dart';

class ChatController extends GetxController {
  final AuthenticationManager authManager = Get.find();
  RxInt firstQuestion = 0.obs;
  RxInt secondQuestion = 0.obs;
  RxInt gotCorrectResult = 0.obs;
  RxList<String> angryList = <String>[].obs, sadList = <String>[].obs;
  List<FeelingCount> feelingCounts = [];

  @override
  Future<void> onInit() async {
    angryList.addAll([
      'Someone touched him',
      'Someone is forcing him to do something he can’t do at this moment in time',
      'feeling hungry or thirsty',
      'Someone is changing the pattern of the colors of his toy',
      'Someone took his stuff',
      'The light is too high or the sounds are too loud',
      'Other',
    ]);

    sadList.addAll([
      'visiting a new place or meeting new people',
      'The mother or father is in a bad mood',
      'Someone is staring at him for too long',
      'Got bullied',
      'Changed his daily routine',
      'Other',
    ]);

    var data = authManager.storage.read('feelingCounts');

    List<dynamic> temp = data == null ? [] : jsonDecode(data);

    feelingCounts.addAll(temp.isEmpty
        ? []
        : temp
            .map<FeelingCount>((jsonItem) {
              return FeelingCount.fromJson(jsonItem);
            })
            .toList()
            .toList());

    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  Future<void> addCount(String feelingName) async {
    int index = feelingCounts.indexWhere((feeling) =>
        (feeling.feelingName == feelingName) &&
        (feeling.apId == authManager.currentChildId.value));
    if (index >= 0) {
      feelingCounts[index].counts = feelingCounts[index].counts! + 1;
      print(feelingCounts[index].counts);
    } else {
      FeelingCount feelingCount = FeelingCount(
        apId: authManager.currentChildId.value,
        feelingName: feelingName,
        counts: 1,
      );
      feelingCounts.add(feelingCount);
    }

    await authManager.storage.write('feelingCounts', jsonEncode(feelingCounts));
  }
}
