import 'dart:io';

import 'package:permission_handler/permission_handler.dart';
import 'package:yelody_app/services/device_info_service.dart';

enum PermissionStatusResult {
  granted,
  denied,
  permanentlyDenied,
}

class PermissionManager {
  static Future<PermissionStatusResult> requestStoragePermission() async {
    PermissionStatus status = await Permission.storage.request();
    return _convertPermissionStatus(status);
  }

  static Future<PermissionStatusResult> requestAudioPermission() async {
    PermissionStatus status = await Permission.microphone.request();
    return _convertPermissionStatus(status);
  }

  static Future<PermissionStatusResult> requestAllPermissions() async {
    final sdkInfo =
        Platform.isAndroid ? await DeviceInfoService.instance.getSdk() : 0;

    final isAndroid = Platform.isAndroid;

    Map<Permission, PermissionStatus> statuses = await [
      if (isAndroid) sdkInfo > 32 ? Permission.audio : Permission.storage,
      Permission.microphone,
      if (!isAndroid) Permission.storage
      // Permission.manageExternalStorage,
    ].request();

    return _convertMultiplePermissionStatus(statuses);
  }

  static Future<PermissionStatusResult> checkStoragePermission() async {
    final sdkInfo =
        Platform.isAndroid ? await DeviceInfoService.instance.getSdk() : 0;
    print(sdkInfo);
    return Platform.isIOS
        ? _convertPermissionStatus(await Permission.storage.status)
        : _convertPermissionStatus(sdkInfo > 32
            ? await Permission.audio.status
            : await Permission.storage.status);
  }

  static Future<PermissionStatusResult> checkAudioPermission() async {
    return _convertPermissionStatus(await Permission.microphone.status);
  }

  static PermissionStatusResult _convertPermissionStatus(
      PermissionStatus status) {
    if (status == PermissionStatus.granted) {
      return PermissionStatusResult.granted;
    } else if (status == PermissionStatus.denied) {
      return PermissionStatusResult.denied;
    } else {
      return PermissionStatusResult.permanentlyDenied;
    }
  }

  static PermissionStatusResult _convertMultiplePermissionStatus(
      Map<Permission, PermissionStatus> statuses) {
    if (statuses.values.every((status) => status == PermissionStatus.granted)) {
      return PermissionStatusResult.granted;
    } else if (statuses.values
        .any((status) => status == PermissionStatus.denied)) {
      return PermissionStatusResult.denied;
    } else {
      return PermissionStatusResult.permanentlyDenied;
    }
  }
}
