import 'package:click_yt/data/repositories/shared_preferences_download_history_repository.dart';
import 'package:click_yt/domain/entities/download_task.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('load devuelve lista vacía cuando no hay historia', () async {
    final repository = SharedPreferencesDownloadHistoryRepository();
    expect(await repository.load(), isEmpty);
  });

  test('save + load es un roundtrip completo', () async {
    final repository = SharedPreferencesDownloadHistoryRepository();
    final task = DownloadTask(
      id: '1',
      videoTitle: 'Test',
      videoUrl: 'https://youtu.be/abc',
      quality: VideoQualities.muxed.quality,
      filePath: '/data/Click_yt/test.mp4',
      status: DownloadStatus.completed,
      progress: 1.0,
      createdAt: DateTime(2026, 1, 1, 10, 30),
      completedAt: DateTime(2026, 1, 1, 11, 0),
    );

    await repository.save([task]);
    final loaded = await repository.load();

    expect(loaded, hasLength(1));
    expect(loaded.single.id, task.id);
    expect(loaded.single.videoTitle, task.videoTitle);
    expect(loaded.single.status, task.status);
    expect(loaded.single.filePath, task.filePath);
    expect(loaded.single.createdAt, task.createdAt);
  });

  test('save reemplaza la historia anterior', () async {
    final repository = SharedPreferencesDownloadHistoryRepository();
    final first = DownloadTask(
      id: '1',
      videoTitle: 'Primero',
      videoUrl: 'https://youtu.be/abc',
      quality: '360',
      status: DownloadStatus.completed,
      createdAt: DateTime(2026, 1, 1),
    );
    final second = DownloadTask(
      id: '2',
      videoTitle: 'Segundo',
      videoUrl: 'https://youtu.be/def',
      quality: '720',
      status: DownloadStatus.failed,
      createdAt: DateTime(2026, 1, 2),
    );

    await repository.save([first, second]);
    await repository.save([second]);

    final loaded = await repository.load();
    expect(loaded, hasLength(1));
    expect(loaded.single.id, '2');
  });
}