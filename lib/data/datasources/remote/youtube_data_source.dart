import 'package:click_yt/domain/entities/video_info.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeDataSource {
  final YoutubeExplode yt;
  final Future<StreamManifest> manifestFuture;
  final String videoId;

  YoutubeDataSource({
    required this.manifestFuture,
    required this.videoId,
    required this.yt,
  });

  factory YoutubeDataSource.getManifest(String url) {
    var videoId = YoutubeDataSource.extractVideoId(url);
    if (videoId == null) throw 'Invalid Youtube Link';
    var yt = YoutubeExplode();
    var manifest = yt.videos.streamsClient.getManifest(videoId);
    return YoutubeDataSource(manifestFuture: manifest, videoId: videoId, yt: yt);
  }

  Future<(StreamInfo streamInfo, Stream<List<int>>)> getMuxedStream() async {
    final manifest = await manifestFuture;
    final streamInfo = manifest.muxed.bestQuality;
    final stream = yt.videos.streams.get(streamInfo);
    return (streamInfo, stream);
  }

  Future<(StreamInfo streamInfo, Stream<List<int>> stream)>
      getAudioStream() async {
    final manifest = await manifestFuture;
    final streamInfo = manifest.audioOnly.withHighestBitrate();
    final stream = yt.videos.streamsClient.get(streamInfo);
    return (streamInfo, stream);
  }

  Future<VideoInfo> getVideoInfo() async {
    // Title and thumbnail
    var video = await yt.videos.get(videoId);
    final title = video.title;
    final thumbnail = video.thumbnails.maxResUrl;
    var manifest = await manifestFuture;

    // Audio Stream Info
    final audioStreamInfo = manifest.audioOnly.withHighestBitrate();
    final audioSize = audioStreamInfo.size.totalMegaBytes;

    // Video Stream Info

    var videoMuxedStreamInfo = manifest.muxed.bestQuality;
    var videoHighestStreamInfo = manifest.video.withHighestBitrate();

    var videoMuxedSize = videoMuxedStreamInfo.size.totalMegaBytes;
    var videoHighestSize = videoHighestStreamInfo.size.totalMegaBytes;

    return VideoInfo(
      title: title,
      thumbnailUrl: thumbnail,
      sizes: (
        audioSize: audioSize,
        videoMuxedSize: videoMuxedSize,
        videoHighestSize: videoHighestSize,
      ),
    );
  }

  static bool isYoutubeUrl(String url) {
    final uri = Uri.tryParse(url);

    if (uri == null) return false;
    if (uri.host.contains('youtu.be')) return true;
    if (uri.host.contains('youtube.com')) return true;

    return false;
  }

  static String? extractVideoId(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return null;

    if (uri.host.contains('youtube.com')) {
      if (uri.pathSegments.contains('shorts')) return uri.pathSegments.last;
      return uri.queryParameters['v'];
    }

    if (uri.host.contains('youtu.be')) {
      return uri.pathSegments.first;
    }
    return null;
  }
}