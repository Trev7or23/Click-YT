import 'dart:convert';

import 'package:click_yt/data/mappers/download_task_mapper.dart';
import 'package:click_yt/domain/entities/download_task.dart';
import 'package:click_yt/domain/repositories/download_history_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesDownloadHistoryRepository
    implements DownloadHistoryRepository {
  static const _key = 'download_history';

  @override
  Future<List<DownloadTask>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString == null) return [];

    final jsonList = jsonDecode(jsonString) as List;
    return jsonList
        .map(
          (json) =>
              DownloadTaskMapper.fromJson(json as Map<String, dynamic>),
        )
        .toList();
  }

  @override
  Future<void> save(List<DownloadTask> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = tasks.map(DownloadTaskMapper.toJson).toList();
    await prefs.setString(_key, jsonEncode(jsonList));
  }
}