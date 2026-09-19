import 'dart:async';

import 'package:click_yt/core/themes/app_colors.dart';
import 'package:click_yt/core/themes/text_styles.dart';
import 'package:click_yt/data/datasources/remote/youtube_data_source.dart';
import 'package:click_yt/domain/entities/download_task.dart';
import 'package:click_yt/presentation/widgets/home/download_modal.dart';
import 'package:click_yt/presentation/widgets/ui/app_snack_bar.dart';
import 'package:click_yt/presentation/widgets/ui/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../providers/download_provider.dart';

class SearchField extends StatefulWidget {
  final TextEditingController _controller;

  const SearchField({super.key, required this._controller});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.white),

      controller: widget._controller,
      onSubmitted: (_) => _onPressed(),

      decoration: InputDecoration(
        hintStyle: TextStyles.primary,
        hintText: 'Paste a Youtube link...',
        prefixIcon: const Icon(
          Icons.download,
          color: AppColors.accent,
          semanticLabel: 'download Icon',
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 3),
          child: IconButton(
            color: AppColors.foreground,
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(AppColors.accent),
              shape: WidgetStatePropertyAll(CircleBorder()),
            ),
            onPressed: () => _onPressed(),
            icon: const Icon(Icons.search, size: 30, semanticLabel: 'Search'),
          ),
        ),
      ),
    );
  }

  void _onPressed() async {
    final url = widget._controller.text;

    if (url.isEmpty) return;

    try {
      if (!YoutubeDataSource.isYoutubeUrl(url)) {
        throw ErrorDescription('Invalid Url Link');
      }
      //Show Loading Dialog
      unawaited(
        showDialog(context: context, builder: (_) => const LoadingDialog()),
      );

      final downloadProvider = context.read<DownloadProvider>();
      final videoInfo = await downloadProvider.getVideoInfo(url);

      if (mounted) context.pop();
      if (mounted) {
        showModalBottomSheet<void>(
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          context: context,
          builder: (_) => DownloadModal(
            title: videoInfo.title,
            thumbnailUrl: videoInfo.thumbnailUrl,
            sizes: videoInfo.sizes,
            onPressed: () async => await downloadProvider.startDownload(
              url: url,
              quality: VideoQualities.muxed,
            ),
          ),
        );
        widget._controller.clear();
      }
    } catch (e) {
      if (!mounted) return;
      AppSnackBar.error(context, e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget._controller.dispose();
  }
}
