import 'package:click_yt/data/mappers/download_task_mapper.dart';
import 'package:click_yt/domain/entities/download_task.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DownloadTaskMapper', () {
    test('roundtrip completa conserva todos los campos', () {
      final task = DownloadTask(
        id: '1',
        videoTitle: 'Título de prueba',
        videoUrl: 'https://youtu.be/abc123',
        quality: VideoQualities.muxed.quality,
        filePath: '/data/Click_yt/test.mp4',
        status: DownloadStatus.completed,
        progress: 1.0,
        createdAt: DateTime(2026, 1, 1, 10, 30),
        completedAt: DateTime(2026, 1, 1, 11, 0),
        errorMessage: null,
      );

      final json = DownloadTaskMapper.toJson(task);
      final restored = DownloadTaskMapper.fromJson(json);

      expect(restored.id, task.id);
      expect(restored.videoTitle, task.videoTitle);
      expect(restored.videoUrl, task.videoUrl);
      expect(restored.quality, task.quality);
      expect(restored.filePath, task.filePath);
      expect(restored.status, task.status);
      expect(restored.progress, task.progress);
      expect(restored.createdAt, task.createdAt);
      expect(restored.completedAt, task.completedAt);
      expect(restored.errorMessage, task.errorMessage);
    });

    test('roundtrip con campos opcionales nulos', () {
      final task = DownloadTask(
        id: '2',
        videoTitle: 'Sin archivo',
        videoUrl: 'https://youtu.be/xyz789',
        quality: VideoQualities.audio.quality,
        status: DownloadStatus.failed,
        createdAt: DateTime(2026, 2, 2, 8, 0),
      );

      final restored = DownloadTaskMapper.fromJson(
        DownloadTaskMapper.toJson(task),
      );

      expect(restored.filePath, isNull);
      expect(restored.completedAt, isNull);
      expect(restored.errorMessage, isNull);
    });

    test('encodea y decodifica cada DownloadStatus', () {
      for (final status in DownloadStatus.values) {
        final task = DownloadTask(
          id: 's',
          videoTitle: 't',
          videoUrl: 'https://youtu.be/abc',
          quality: '360',
          status: status,
          createdAt: DateTime(2026, 1, 1),
        );
        final restored = DownloadTaskMapper.fromJson(
          DownloadTaskMapper.toJson(task),
        );
        expect(restored.status, status, reason: 'status $status');
      }
    });
  });
}