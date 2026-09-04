// models/youtube_download.dart
import 'package:flutter/material.dart';

class YoutubeVideoInfo {
  final String id;
  final String title;
  final String author;
  final String thumbnailUrl;
  final Duration duration;
  final List<VideoQuality> qualities;
  final List<AudioQuality> audioQualities;

  YoutubeVideoInfo({
    required this.id,
    required this.title,
    required this.author,
    required this.thumbnailUrl,
    required this.duration,
    required this.qualities,
    required this.audioQualities,
  });
}

class VideoQuality {
  final String label;
  final int height;
  final String itag;
  final String mimeType;
  final int? bitrate;

  VideoQuality({
    required this.label,
    required this.height,
    required this.itag,
    required this.mimeType,
    this.bitrate,
  });
}

class AudioQuality {
  final String label;
  final int bitrate;
  final String itag;
  final String mimeType;

  AudioQuality({
    required this.label,
    required this.bitrate,
    required this.itag,
    required this.mimeType,
  });
}

enum DownloadStatus {
  pending,
  fetching,
  downloading,
  paused,
  completed,
  failed,
  cancelled,
}

extension DownloadStatusExtension on DownloadStatus {
  String get displayName {
    switch (this) {
      case DownloadStatus.pending:
        return 'Pendiente';
      case DownloadStatus.fetching:
        return 'Obteniendo información';
      case DownloadStatus.downloading:
        return 'Descargando';
      case DownloadStatus.paused:
        return 'Pausado';
      case DownloadStatus.completed:
        return 'Completado';
      case DownloadStatus.failed:
        return 'Fallido';
      case DownloadStatus.cancelled:
        return 'Cancelado';
    }
  }

  Color get color {
    switch (this) {
      case DownloadStatus.pending:
        return Colors.grey;
      case DownloadStatus.fetching:
        return Colors.blue;
      case DownloadStatus.downloading:
        return Colors.blue;
      case DownloadStatus.paused:
        return Colors.orange;
      case DownloadStatus.completed:
        return Colors.green;
      case DownloadStatus.failed:
        return Colors.red;
      case DownloadStatus.cancelled:
        return Colors.grey;
    }
  }
}
