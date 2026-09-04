
typedef VideoSizes = ({
  double audioSize,
  double videoMuxedSize,
  double videoHighestSize,
});

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

  Map<String, dynamic> toJson() => {
    'id': id,
    'videoTitle': videoTitle,
    'videoUrl': videoUrl,
    'quality': quality,
    'filePath': filePath,
    'status': status.index,
    'progress': progress,
    'createdAt': createdAt.toIso8601String(),
    'completedAt': completedAt?.toIso8601String(),
    'errorMessage': errorMessage,
  };

  factory DownloadTask.fromJson(Map<String, dynamic> json) => DownloadTask(
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
