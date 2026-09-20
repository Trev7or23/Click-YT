import 'dart:async';

import 'package:click_yt/domain/entities/download_task.dart';
import 'package:click_yt/domain/entities/video_info.dart';
import 'package:click_yt/domain/repositories/youtube_repository.dart';

class FakeYoutubeRepository implements YoutubeRepository {
  FakeYoutubeRepository({
    this.videoInfo = const VideoInfo(
      title: 'Video de prueba',
      thumbnailUrl: 'https://example.com/thumb.jpg',
      sizes: (
        audioSize: 100,
        videoMuxedSize: 200,
        videoHighestSize: 300,
      ),
    ),
    this.downloadPath = '/tmp/Click_yt/test.mp4',
    this.throwOnDownload = false,
    this.holdDownload = false,
  });

  final VideoInfo videoInfo;
  final String downloadPath;
  bool throwOnDownload;
  bool holdDownload;

  int getVideoInfoCalls = 0;
  int downloadCalls = 0;
  final List<Completer<String>> pendingDownloads = [];

  @override
  Future<VideoInfo> getVideoInfo(String url) async {
    getVideoInfoCalls++;
    return videoInfo;
  }

  @override
  Future<String> downloadVideo({
    required String url,
    required VideoQualities quality,
    required void Function(double progress) onProgress,
  }) async {
    downloadCalls++;
    if (throwOnDownload) throw Exception('download failed');

    if (holdDownload) {
      final completer = Completer<String>();
      pendingDownloads.add(completer);
      return completer.future;
    }

    onProgress(0.5);
    onProgress(1.0);
    return downloadPath;
  }
}