import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoService {
  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  // Private constructor
  DeviceInfoService._();

  // Static instance variable to hold the single instance
  static DeviceInfoService? _instance;

  // Static method to access the single instance
  static DeviceInfoService get instance {
    // Create the instance if it doesn't exist
    _instance ??= DeviceInfoService._();
    return _instance!;
  }

  // Add your class methods and properties here
  // For example:
  Future<int> getSdk() async {
    final sdk = await _deviceInfoPlugin.androidInfo;
    return sdk.version.sdkInt;
  }
}
