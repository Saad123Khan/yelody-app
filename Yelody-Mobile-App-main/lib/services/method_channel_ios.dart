// native_method_channel_service.dart
import 'dart:developer';

import 'package:flutter/services.dart';

class NativeMethodChannelService {
  static const MethodChannel _channel =
      MethodChannel('flutter-ios-audio-channel');

  static Future<void> setPitch(double pitch) async {
    try {
      log("Setting Pitch  Natively");
      await _channel.invokeMethod('changePitch', {'pitch': pitch});
    } on PlatformException catch (e) {
      print("Failed to set pitch: '${e.message}'.");
    }
  }
}
