import 'dart:io';

import 'package:path_provider/path_provider.dart';

class CustomPathManager {
  static Future<String> getApplicationDocumentsDirectoryPath() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<String> createCustomPath([String? custom]) async {
    final String documentsDirectory =
        await getApplicationDocumentsDirectoryPath();
    String customPath = "";
    if (custom != null) {
      customPath = '$documentsDirectory/Yelody/AudioCaches/$custom';
    } else {
      customPath = '$documentsDirectory/Yelody/AudioCaches';
    }

    // Check if the directory already exists
    final bool directoryExists = await Directory(customPath).exists();

    if (!directoryExists) {
      // Create the custom directory if it doesn't exist
      await Directory(customPath).create(recursive: true);
      print('Custom directory created: $customPath');
    } else {
      print('Custom directory already exists: $customPath');
    }

    return customPath;
  }
}
