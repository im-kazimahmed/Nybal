import 'package:nybal/utils/validators.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class AppPermissions {
  static Future<bool> checkStoragePermission() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      if (await Permission.storage.request().isGranted) {
        return true;
      }
      return false;
    }
    if (status.isRestricted) {
      showShortToast("Storage Permission Error");
      // AppUtility.showError("Storage Permission Error");
      return false;
    }
    if (status.isPermanentlyDenied) {
      await openAppSettings();
      return false;
    }

    return true;
  }

  static Future<bool> checkCameraPermission() async {
    var status = await Permission.camera.status;
    if (status.isDenied) {
      if (await Permission.camera.request().isGranted) {
        return true;
      }
      return false;
    }
    if (status.isRestricted) {
      // AppUtility.showError('Camera Permission Error');
      showShortToast("Camera Permission Error");

      return false;
    }
    if (status.isPermanentlyDenied) {
      await openAppSettings();
      return false;
    }
    return true;
  }

  static Future<bool> checkMicPermission() async {
    var status = await Permission.microphone.status;
    if (status.isDenied) {
      if (await Permission.microphone.request().isGranted) {
        return true;
      }
      return false;
    }
    if (status.isRestricted) {
      // AppUtility.showError('Microphone Permission Error');
      showShortToast("Microphone Permission Error");
      return false;
    }
    if (status.isPermanentlyDenied) {
      await openAppSettings();
      return false;
    }
    return true;
  }
}
