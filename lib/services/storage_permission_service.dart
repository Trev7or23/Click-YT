import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

import 'dart:io';

class StoragePermissionService {
  /// Solicita permisos para guardar audio y video
  static Future<bool> requestPermission() async {
    // Si es iOS, pedir permisos de fotos (o el que corresponda)
    if (Platform.isIOS) {
      final status = await Permission.photos.request();
      return status.isGranted;
    }

    // Si es Android, verificar la versión
    if (Platform.isAndroid) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      final sdkInt = androidInfo.version.sdkInt;

      // Android 13+ (API 33+)
      if (sdkInt >= 33) {
        return await _requestPermissionAndroid13();
      }
      // Android 12 o inferior (API 32 o menos)
      else {
        return await _requestPermissionOldAndroid();
      }
    }

    return false;
  }

  /// Para Android 13 en adelante
  static Future<bool> _requestPermissionAndroid13() async {
    // Pedir permisos específicos para audio y video
    final audioStatus = await Permission.audio.request();
    final videoStatus = await Permission.videos.request();

    // También puedes pedir Permission.photos si necesitas imágenes
    // final photosStatus = await Permission.photos.request();

    return audioStatus.isGranted && videoStatus.isGranted;
  }

  /// Para Android 12 y anteriores
  static Future<bool> _requestPermissionOldAndroid() async {
    final status = await Permission.storage.request();
    return status.isGranted;
  }

  /// Verificar si ya tenemos permisos (sin pedirlos)
  static Future<bool> checkPermission() async {
    if (Platform.isAndroid) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;

      if (androidInfo.version.sdkInt >= 33) {
        final audio = await Permission.audio.status;
        final video = await Permission.videos.status;
        return audio.isGranted && video.isGranted;
      } else {
        final status = await Permission.storage.status;
        return status.isGranted;
      }
    } else if (Platform.isIOS) {
      final status = await Permission.photos.status;
      return status.isGranted;
    }
    return false;
  }
}
