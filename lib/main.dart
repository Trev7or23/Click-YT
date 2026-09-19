import 'dart:io';

import 'package:click_yt/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid || Platform.isIOS) {
    await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  }

  runApp(const MainApp());
}