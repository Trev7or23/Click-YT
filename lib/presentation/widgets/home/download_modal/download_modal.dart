import 'package:click_yt/core/themes/app_colors.dart';
import 'package:click_yt/domain/entities/download_task.dart';
import 'package:click_yt/domain/entities/video_info.dart';
import 'package:click_yt/presentation/widgets/home/download_modal/thumbnail_and_title.dart';
import 'package:click_yt/presentation/widgets/home/download_modal/video_quality_items.dart';
import 'package:click_yt/presentation/widgets/ui/styled_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DownloadModal extends StatefulWidget {
  final String title;
  final String thumbnailUrl;
  final VideoSizes sizes;
  final ValueChanged<VideoQualities> _onPressed;

  const DownloadModal({
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
  VideoQualities _selectedQuality = VideoQualities.muxed;

  @override
  Widget build(BuildContext context) {
    return _CustomDraggableScrollableSheet(
      child: Column(
        spacing: 8,
        children: [
          _dragHandle(),
          const StyledText('Download', alignment: Alignment.topLeft),
          ThumbnailAndTitle(
            videoTitle: widget.title,
            thumbnailUrl: widget.thumbnailUrl,
          ),
          VideoQualityItems(
            sizes: widget.sizes,
            onChanged: (value) => setState(() => _selectedQuality = value),
            selectedQuality: _selectedQuality,
          ),

          // const Spacer(),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(AppColors.accent),
              ),
              onPressed: () {
                context.pop();
                widget._onPressed(_selectedQuality);
              },
              child: const StyledText('Download', fontSize: 32),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dragHandle() {
    return Container(
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

class _CustomDraggableScrollableSheet extends StatelessWidget {
  final Widget child;

  const new({required this.child});

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
        child: child,
      ),
    );
  }
}
