import 'package:neds/App/Services/AuthenticationService/Core/manager.dart';
import 'package:neds/App/Services/PermissionService/permission_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerPermissionService implements PermissionService {
  final AuthenticationManager authManager = Get.find();

  @override
  Future<PermissionStatus> requestCameraPermission() async {
    return await Permission.camera.request();
  }

  @override
  Future<PermissionStatus> requestPhotosPermission() async {
    return await Permission.photos.request();
  }

  @override
  Future<bool> handleCameraPermission(BuildContext context) async {
    PermissionStatus cameraPermissionStatus = await requestCameraPermission();

    if (cameraPermissionStatus != PermissionStatus.granted) {
      authManager.commonTools.ShowWarningDialogMutliButtons(
          context,
          'cameraPermission'.tr,
          'cameraPermissionMess'.tr,
          'openSettings'.tr,
          'ok'.tr,
          CupertinoColors.activeBlue,
          CupertinoColors.activeBlue, () {
        openAppSettings();
      }, () {
        Get.back();
      });

      return false;
    }
    return true;
  }

  @override
  Future<bool> handlePhotosPermission(BuildContext context) async {
    PermissionStatus photosPermissionStatus = await requestPhotosPermission();
    print('d');
    if (photosPermissionStatus == PermissionStatus.denied ||
        photosPermissionStatus == PermissionStatus.permanentlyDenied ||
        photosPermissionStatus == PermissionStatus.restricted) {
      authManager.commonTools.ShowWarningDialogMutliButtons(
          context,
          'photosPermission'.tr,
          'photosPermissionnMess'.tr,
          'openSettings'.tr,
          'ok'.tr,
          CupertinoColors.activeBlue,
          CupertinoColors.activeBlue, () {
        openAppSettings();
      }, () {
        Get.back();
      });

      return false;
    }
    return true;
  }
}
