import 'package:click_yt/domain/entities/download_task.dart';
import 'package:click_yt/domain/entities/video_info.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';

import 'package:click_yt/presentation/widgets/ui/ui.dart';

enum CategoryIcon { audio, video }

class VideoQualityItems extends StatelessWidget {
  final VideoSizes sizes;
  final VideoQualities selectedQuality;
  final ValueChanged<VideoQualities> onChanged;

  const VideoQualityItems({
    super.key,
    required this.sizes,
    required this.onChanged,
    required this.selectedQuality,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          RadioGroup(
            groupValue: selectedQuality,
            onChanged: (value) {
              if (value != null) onChanged(value);
            },
            child: Material(
              type: MaterialType.transparency,
              child: Column(
                children: [
                  // Audio Category
                  const CategoryText('Audio'),
                  _QualityItem(
                    'Fast',
                    size: sizes.audioSize,
                    quality: VideoQualities.audio,
                    categoryIcon: CategoryIcon.audio,
                  ),
                  _QualityItem(
                    'Classic MP3',
                    size: sizes.audioSize,
                    quality: VideoQualities.mp3,
                    categoryIcon: CategoryIcon.audio,
                  ),

                  // Video Category
                  const CategoryText('Video'),
                  _QualityItem(
                    '360P',
                    size: sizes.videoMuxedSize,
                    quality: VideoQualities.muxed,
                    categoryIcon: CategoryIcon.video,
                  ),
                  _QualityItem(
                    '720P',
                    size: sizes.videoHighestSize,
                    quality: VideoQualities.high,
                    categoryIcon: CategoryIcon.video,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QualityItem extends StatelessWidget {
  final String text;
  final int size;
  final VideoQualities quality;
  final CategoryIcon categoryIcon;

  const _QualityItem(
    this.text, {
    required this.size,
    required this.categoryIcon,
    required this.quality,
  });

  @override
  Widget build(BuildContext context) {
    final IconData icon = categoryIcon == CategoryIcon.audio
        ? Icons.music_video
        : Icons.movie;
    return RadioListTile(
      contentPadding: const EdgeInsetsGeometry.all(0),
      controlAffinity: ListTileControlAffinity.trailing,
      value: quality,
      title: Row(
        spacing: 10,
        children: [
          Icon(icon),
          Expanded(child: Text(text)),
          Text(filesize(size.toInt(), 2)),
        ],
      ),
    );
  }
}
