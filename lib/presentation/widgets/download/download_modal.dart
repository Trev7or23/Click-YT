import 'package:click_yt/config/themes/app_colors.dart';
import 'package:click_yt/config/themes/text_styles.dart';
import 'package:click_yt/domain/entities/download_task.dart';
import 'package:click_yt/presentation/widgets/ui/styled_text.dart';
import 'package:flutter/material.dart';

enum CategoryIcon { audio, video }

class DownloadModal extends StatefulWidget {
  final String title;
  final String thumbnailUrl;
  final VideoSizes sizes;
  final VoidCallback _onPressed;

  const new({
    super.key,
    required this.title,
    required this.thumbnailUrl,
    required this.sizes,
    required this._onPressed,
  });
  @override
  State<DownloadModal> createState() => _DownloadModalState();
}

class _DownloadModalState extends State<DownloadModal> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      minChildSize: 0.5,
      maxChildSize: 1,
      builder: (context, scrollController) => Container(
        decoration: const BoxDecoration(
          color: AppColors.backgroundComponent,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary,
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),

        padding: const EdgeInsets.all(20),
        child: _content(),
      ),
    );
  }

  Widget _content() {
    return Column(
      spacing: 8,
      children: [
        Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(2),
          ),
        ),

        Text(
          'Download',
          style: TextStyles.important,
          textAlign: TextAlign.left,
        ),

        _thumbnailAndTitle(),
        _categoryText('Audio'),
        _qualityItem('Fast', widget.sizes.audioSize),
        _qualityItem('Classic MP3', widget.sizes.audioSize),

        _categoryText('Video'),
        _qualityItem(
          '360P',
          widget.sizes.videoMuxedSize,
          categoryIcon: CategoryIcon.video,
        ),
        _qualityItem(
          '720P',
          widget.sizes.videoHighestSize,
          categoryIcon: CategoryIcon.video,
        ),

        const Spacer(),
        SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(AppColors.accent),
            ),
            onPressed: widget._onPressed,
            child: const StyledText('Download', fontSize: 27),
          ),
        ),
      ],
    );
  }

  StyledText _categoryText(String text) {
    return StyledText(
      text,
      alignment: Alignment.centerLeft,
      color: Colors.grey,
      fontSize: 18,
    );
  }

  Row _thumbnailAndTitle() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _image(),
        const SizedBox(width: 5),
        Expanded(
          child: Column(
            children: [
              const SizedBox(height: 15),
              StyledText(
                widget.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                alignment: Alignment.topLeft,
              ),

              const StyledText(
                'youtube.com',
                alignment: Alignment.bottomLeft,
                color: Colors.white54,
              ),
            ],
          ),
        ),
      ],
    );
  }

  ClipRRect _image() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: FadeInImage(
        placeholder: const AssetImage('assets/images/placeholder.png'),
        image: NetworkImage(widget.thumbnailUrl),
        width: 120,
        height: 90,
      ),
    );
  }

  Row _qualityItem(
    String text,
    double size, {
    CategoryIcon categoryIcon = CategoryIcon.audio,
  }) {
    var icon = categoryIcon == CategoryIcon.audio
        ? Icons.music_video
        : Icons.video_library;

    final currentSize = size > 1024 ? size / 1024 : size;
    final byteSize = size > 1024 ? 'GB' : 'MB';

    return Row(
      children: [
        Icon(icon, color: Colors.white70, semanticLabel: 'Video Icon'),
        const SizedBox(width: 10),
        StyledText(text, alignment: Alignment.centerLeft),
        const Spacer(),
        StyledText('${currentSize.toStringAsFixed(1)} $byteSize'),
        Checkbox(
          value: false,
          onChanged: (_) {},
          activeColor: Colors.blue,
          checkColor: Colors.white54,
        ),
      ],
    );
  }
}
