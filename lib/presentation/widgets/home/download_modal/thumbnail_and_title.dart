import 'package:click_yt/presentation/widgets/ui/styled_text.dart';
import 'package:flutter/material.dart';

class ThumbnailAndTitle extends StatelessWidget {
  final String videoTitle;
  final String thumbnailUrl;

  const ThumbnailAndTitle({
    super.key,
    required this.videoTitle,
    required this.thumbnailUrl,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _VideoThumbnail(thumbnailUrl: thumbnailUrl),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            children: [
              const SizedBox(height: 10),
              StyledText(
                videoTitle,
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
}

class _VideoThumbnail extends StatelessWidget {
  final String _thumbnailUrl;

  const _VideoThumbnail({required this._thumbnailUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: FadeInImage(
        fit: BoxFit.cover,
        placeholder: const AssetImage('assets/images/placeholder.png'),
        image: NetworkImage(_thumbnailUrl),
        width: 120,
        height: 90,
        imageErrorBuilder: (context, error, stackTrace) => Image.asset(
          'assets/images/placeholder.png',
          width: 120,
          height: 90,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
