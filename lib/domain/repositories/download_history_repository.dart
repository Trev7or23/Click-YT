import 'package:click_yt/domain/entities/download_task.dart';

abstract class DownloadHistoryRepository {
  Future<List<DownloadTask>> load();

  Future<void> save(List<DownloadTask> tasks);
}