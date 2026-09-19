import 'dart:io';

import 'package:click_yt/data/datasources/platform/storage_permission_data_source.dart';
import 'package:click_yt/data/datasources/remote/youtube_data_source.dart';
import 'package:click_yt/domain/entities/download_task.dart';
import 'package:path_provider/path_provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class DownloadRepository {
  Future<String> downloadVideo({
    required String url,
    required VideoQualities quality,
    required void Function(double progress) onProgress,
  }) async {
    try {
      // Solicitar permisos en Android
      if (Platform.isAndroid) {
        final status =
            await StoragePermissionDataSource.requestPermission();
        if (!status) {
          throw Exception('Permiso de almacenamiento denegado');
        }
      }

      // Obtener información del video
      final ytDownloader = YoutubeDataSource.getManifest(url);
      final video = await ytDownloader.getVideoInfo();

      StreamInfo streamInfo;
      Stream<List<int>> stream;

      if (quality == VideoQualities.audio) {
        // Solo audio
        (streamInfo, stream) = await ytDownloader.getAudioStream();
      } else {
        // Video con audio
        (streamInfo, stream) = await ytDownloader.getMuxedStream();
      }

      // Obtener directorio de descargas
      Directory downloadsDir;
      if (Platform.isAndroid) {
        downloadsDir = Directory('/storage/emulated/0/Download');
        if (!await downloadsDir.exists()) {
          downloadsDir =
              await getExternalStorageDirectory() ??
              await getApplicationDocumentsDirectory();
        }
      } else {
        downloadsDir = await getApplicationDocumentsDirectory();
      }

      // Crear nombre de archivo
      final extension = streamInfo.container.name;
      final fileName =
          '${video.title.replaceAll(RegExp(r'[<>:"/\\|?*]'), '')}.$extension';
      final filePath = '${downloadsDir.path}/$fileName';

      // Descargar el archivo
      final file = File(filePath);

      // Descargar con progreso
      final totalBytes = streamInfo.size.totalBytes;

      var downloadedBytes = 0;

      final outputStream = file.openWrite();

      await for (final chunk in stream) {
        outputStream.add(chunk);
        downloadedBytes += chunk.length;

        if (totalBytes > 0) {
          final progress = downloadedBytes / totalBytes;
          onProgress(progress);
        }
      }

      await outputStream.flush();
      await outputStream.close();

      return filePath;
    } catch (e) {
      throw Exception('Error al descargar: $e');
    }
  }
}