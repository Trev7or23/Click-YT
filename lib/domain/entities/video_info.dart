typedef VideoSizes = ({
  double audioSize,
  double videoMuxedSize,
  double videoHighestSize,
});

class VideoInfo {
  final String title;
  final String thumbnailUrl;
  final VideoSizes sizes;

  const VideoInfo({
    required this.title,
    required this.thumbnailUrl,
    required this.sizes,
  });
}

