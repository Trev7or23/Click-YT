import 'package:click_yt/domain/entities/download_task.dart';
import 'package:click_yt/domain/entities/video_info.dart';

abstract class YoutubeRepository {
  Future<VideoInfo> getVideoInfo(String url);

  Future<String> downloadVideo({
    required String url,
    required VideoQualities quality,
    required void Function(double progress) onProgress,
  });
}