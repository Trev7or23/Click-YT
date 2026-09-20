import 'package:click_yt/domain/entities/download_task.dart';
import 'package:click_yt/domain/repositories/download_history_repository.dart';

class FakeDownloadHistoryRepository implements DownloadHistoryRepository {
  List<DownloadTask> stored = [];
  int saveCalls = 0;
  int loadCalls = 0;
  bool throwOnLoad = false;
  bool throwOnSave = false;

  @override
  Future<List<DownloadTask>> load() async {
    loadCalls++;
    if (throwOnLoad) throw Exception('load failed');
    return List.of(stored);
  }

  @override
  Future<void> save(List<DownloadTask> tasks) async {
    saveCalls++;
    if (throwOnSave) throw Exception('save failed');
    stored = List.of(tasks);
  }
}