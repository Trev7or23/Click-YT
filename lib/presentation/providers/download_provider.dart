// providers/download_provider.dart
import 'package:click_yt/domain/entities/download_task.dart';
import 'package:click_yt/domain/entities/video_info.dart';
import 'package:click_yt/domain/repositories/download_history_repository.dart';
import 'package:click_yt/domain/repositories/youtube_repository.dart';
import 'package:flutter/material.dart';

import 'dart:async';

class DownloadProvider extends ChangeNotifier {
  final YoutubeRepository _youtubeRepository;
  final DownloadHistoryRepository _historyRepository;
  final List<DownloadTask> _tasks = [];
  DownloadTask? _activeTask;

  List<DownloadTask> get tasks => _tasks;
  DownloadTask? get activeTask => _activeTask;

  DownloadProvider({
    required this._youtubeRepository,
    required this._historyRepository,
  }) {
    _loadHistory();
  }

  // Get Video Info
  Future<VideoInfo> getVideoInfo(String url) async {
    return await _youtubeRepository.getVideoInfo(url);
  }

  // Iniciar nueva descarga
  Future<void> startDownload({
    required String url,
    required VideoQualities quality,
  }) async {
    try {
      // Verificar si ya existe una descarga activa
      if (_activeTask != null) {
        throw Exception('Ya hay una descarga en progreso');
      }

      final videoInfo = await _youtubeRepository.getVideoInfo(url);

      // Crear tarea
      final task = DownloadTask(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        videoTitle: videoInfo.title,
        videoUrl: url,
        quality: quality.quality,
        status: DownloadStatus.downloading,
        createdAt: DateTime.now(),
      );

      _activeTask = task;
      _tasks.insert(0, task);
      notifyListeners();
      _saveHistory();

      // Iniciar descarga
      final filePath = await _youtubeRepository.downloadVideo(
        url: url,
        quality: quality,
        onProgress: (progress) {
          // Actualizar progreso
          final updatedTask = _activeTask!.copyWith(progress: progress);
          _activeTask = updatedTask;
          final index = _tasks.indexWhere((t) => t.id == task.id);
          if (index != -1) {
            _tasks[index] = updatedTask;
          }
          notifyListeners();
          unawaited(_saveHistory());
        },
      );

      // Completar descarga
      final completedTask = _activeTask!.copyWith(
        status: DownloadStatus.completed,
        progress: 1.0,
        filePath: filePath,
        completedAt: DateTime.now(),
      );
      _activeTask = null;
      final index = _tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        _tasks[index] = completedTask;
      }
      notifyListeners();
      _saveHistory();
    } catch (e) {
      // Manejar error
      if (_activeTask != null) {
        final failedTask = _activeTask!.copyWith(
          status: DownloadStatus.failed,
          errorMessage: e.toString(),
        );
        _activeTask = null;
        final index = _tasks.indexWhere((t) => t.id == failedTask.id);
        if (index != -1) {
          _tasks[index] = failedTask;
        }
        notifyListeners();
        await _saveHistory();
      }
      rethrow;
    }
  }

  // Cancelar descarga activa
  void cancelActiveDownload() {
    if (_activeTask != null) {
      final cancelledTask = _activeTask!.copyWith(
        status: DownloadStatus.failed,
        errorMessage: 'Cancelado por el usuario',
      );
      _activeTask = null;
      final index = _tasks.indexWhere((t) => t.id == cancelledTask.id);
      if (index != -1) {
        _tasks[index] = cancelledTask;
      }
      notifyListeners();
      unawaited(_saveHistory());
    }
  }

  // Guardar historial
  Future<void> _saveHistory() async {
    await _historyRepository.save(_tasks);
  }

  // Cargar historial
  Future<void> _loadHistory() async {
    try {
      final tasks = await _historyRepository.load();
      _tasks.clear();
      _tasks.addAll(tasks);

      // Verificar si hay una tarea incompleta
      final activeTask = _tasks
          .where((t) => t.status == DownloadStatus.downloading)
          .firstOrNull;
      if (activeTask != null) {
        // Marcar como fallida porque se perdió la conexión
        final failedTask = activeTask.copyWith(
          status: DownloadStatus.failed,
          errorMessage: 'Descarga interrumpida',
        );
        final index = _tasks.indexWhere((t) => t.id == activeTask.id);
        if (index != -1) {
          _tasks[index] = failedTask;
        }
      }
      notifyListeners();
    } catch (e) {
      throw 'Error cargando historial: $e';
    }
  }

  // Limpiar historial
  Future<void> clearHistory() async {
    _tasks.clear();
    _activeTask = null;
    notifyListeners();
    await _saveHistory();
  }
}
