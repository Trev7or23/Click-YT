typedef VideoSizes = ({
  int audioSize,
  int videoMuxedSize,
  int videoHighestSize,
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
