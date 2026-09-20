
enum VideoQualities {
  audio('audio'),
  muxed('360'),
  mp3('mp3'),
  high('720');

  final String quality;
  const VideoQualities(this.quality);
}
enum DownloadStatus { pending, downloading, completed, failed, paused }

class DownloadTask {
  final String id;
  final String videoTitle;
  final String videoUrl;
  final String quality;
  final String? filePath;
  final DownloadStatus status;
  final double progress;
  final DateTime createdAt;
  final DateTime? completedAt;
  final String? errorMessage;

  DownloadTask({
    required this.id,
    required this.videoTitle,
    required this.videoUrl,
    required this.quality,
    this.filePath,
    this.status = DownloadStatus.pending,
    this.progress = 0.0,
    required this.createdAt,
    this.completedAt,
    this.errorMessage,
  });

  DownloadTask copyWith({
    String? id,
    String? videoTitle,
    String? videoUrl,
    String? quality,
    String? filePath,
    DownloadStatus? status,
    double? progress,
    DateTime? createdAt,
    DateTime? completedAt,
    String? errorMessage,
  }) {
    return DownloadTask(
      id: id ?? this.id,
      videoTitle: videoTitle ?? this.videoTitle,
      videoUrl: videoUrl ?? this.videoUrl,
      quality: quality ?? this.quality,
      filePath: filePath ?? this.filePath,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
