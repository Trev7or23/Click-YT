import 'package:click_yt/domain/entities/download_task.dart';

class DownloadTaskMapper {
  static Map<String, dynamic> toJson(DownloadTask task) => {
    'id': task.id,
    'videoTitle': task.videoTitle,
    'videoUrl': task.videoUrl,
    'quality': task.quality,
    'filePath': task.filePath,
    'status': task.status.index,
    'progress': task.progress,
    'createdAt': task.createdAt.toIso8601String(),
    'completedAt': task.completedAt?.toIso8601String(),
    'errorMessage': task.errorMessage,
  };

  static DownloadTask fromJson(Map<String, dynamic> json) => DownloadTask(
    id: json['id'] as String,
    videoTitle: json['videoTitle'] as String,
    videoUrl: json['videoUrl'] as String,
    quality: json['quality'] as String,
    filePath: json['filePath'] as String?,
    status: DownloadStatus.values[json['status'] as int],
    progress: json['progress'] as double? ?? 0.0,
    createdAt: DateTime.parse(json['createdAt'] as String),
    completedAt: json['completedAt'] != null
        ? DateTime.parse(json['completedAt'] as String)
        : null,
    errorMessage: json['errorMessage'] as String?,
  );
}