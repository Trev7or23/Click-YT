import 'dart:io';

import 'package:path_provider/path_provider.dart';

class StorageDataSource {
  static Future<File> saveContent(String filename) async {
    final baseDir = await getApplicationDocumentsDirectory();

    final appDir = Directory('${baseDir.path}/Click_yt');

    if (!await appDir.exists()) {
      await appDir.create(recursive: true);
    }

    return File('${appDir.path}/$filename');
  }
}
