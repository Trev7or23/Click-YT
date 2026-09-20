import 'package:click_yt/domain/entities/download_task.dart';
import 'package:click_yt/presentation/providers/download_provider.dart';

import '../helpers/fake_download_history_repository.dart';
import '../helpers/fake_youtube_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeYoutubeRepository youtube;
  late FakeDownloadHistoryRepository history;
  late DownloadProvider provider;

  setUp(() {
    youtube = FakeYoutubeRepository();
    history = FakeDownloadHistoryRepository();
    provider = DownloadProvider(
      youtubeRepository: youtube,
      historyRepository: history,
    );
  });

  test('getVideoInfo delega al repositorio de youtube', () async {
    final info = await provider.getVideoInfo('https://youtu.be/abc');

    expect(youtube.getVideoInfoCalls, 1);
    expect(info.title, 'Video de prueba');
  });

  test('startDownload agrega la tarea, la completa y persiste', () async {
    await provider.startDownload(
      url: 'https://youtu.be/abc',
      quality: VideoQualities.muxed,
    );

    expect(youtube.downloadCalls, 1);
    expect(provider.tasks, hasLength(1));
    final task = provider.tasks.first;
    expect(task.status, DownloadStatus.completed);
    expect(task.progress, 1.0);
    expect(task.filePath, youtube.downloadPath);
    expect(provider.activeTask, isNull);

    expect(history.stored, hasLength(1));
    expect(history.stored.first.status, DownloadStatus.completed);
  });

  test('startDownload marca la tarea como failed cuando la descarga falla',
      () async {
    youtube.throwOnDownload = true;

    await expectLater(
      provider.startDownload(
        url: 'https://youtu.be/abc',
        quality: VideoQualities.muxed,
      ),
      throwsException,
    );

    expect(provider.tasks, hasLength(1));
    expect(provider.tasks.first.status, DownloadStatus.failed);
    expect(provider.tasks.first.errorMessage, isNotNull);
    expect(provider.activeTask, isNull);
  });

  test('cancelActiveDownload marca la tarea activa como cancelada', () async {
    youtube.holdDownload = true;

    provider.startDownload(
      url: 'https://youtu.be/abc',
      quality: VideoQualities.muxed,
    );
    await Future<void>.delayed(Duration.zero);
    expect(provider.activeTask, isNotNull);

    provider.cancelActiveDownload();

    expect(provider.activeTask, isNull);
    expect(provider.tasks, hasLength(1));
    expect(provider.tasks.first.status, DownloadStatus.failed);
    expect(provider.tasks.first.errorMessage, 'Cancelado por el usuario');
  });

  test('loadHistory marca como failed una tarea interrumpida', () async {
    history.stored = [
      DownloadTask(
        id: '1',
        videoTitle: 'Interrumpida',
        videoUrl: 'https://youtu.be/abc',
        quality: '360',
        status: DownloadStatus.downloading,
        progress: 0.5,
        createdAt: DateTime(2026, 1, 1),
      ),
      DownloadTask(
        id: '2',
        videoTitle: 'Completada',
        videoUrl: 'https://youtu.be/def',
        quality: '720',
        status: DownloadStatus.completed,
        progress: 1.0,
        createdAt: DateTime(2026, 1, 1),
      ),
    ];

    final freshProvider = DownloadProvider(
      youtubeRepository: youtube,
      historyRepository: history,
    );
    await Future<void>.delayed(Duration.zero);

    expect(freshProvider.tasks, hasLength(2));
    expect(freshProvider.tasks.first.status, DownloadStatus.failed);
    expect(freshProvider.tasks.first.errorMessage, 'Descarga interrumpida');
    expect(freshProvider.tasks.last.status, DownloadStatus.completed);
  });

  test('clearHistory limpia las tareas y persiste historia vacía', () async {
    await provider.startDownload(
      url: 'https://youtu.be/abc',
      quality: VideoQualities.muxed,
    );
    expect(provider.tasks, isNotEmpty);

    await provider.clearHistory();

    expect(provider.tasks, isEmpty);
    expect(provider.activeTask, isNull);
    expect(history.stored, isEmpty);
  });
}