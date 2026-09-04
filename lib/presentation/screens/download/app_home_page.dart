import 'dart:async';

import 'package:click_yt/config/downloader/yt_downloader.dart';
import 'package:click_yt/config/themes/app_colors.dart';
import 'package:click_yt/domain/entities/download_task.dart';
import 'package:click_yt/presentation/providers/download_provider.dart';
import 'package:click_yt/presentation/widgets/download/download_modal.dart';
import 'package:click_yt/presentation/widgets/download/search_field.dart';
import 'package:click_yt/presentation/widgets/ui/app_snack_bar.dart';
import 'package:click_yt/presentation/widgets/ui/loading_dialog.dart';
import 'package:click_yt/presentation/widgets/ui/styled_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppHomePage extends StatefulWidget {
  const new({super.key});

  @override
  State<AppHomePage> createState() => _AppHomePageState();
}

class _AppHomePageState extends State<AppHomePage> {
  final TextEditingController _urlController = TextEditingController();
  String? _latestUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (context, provider, child) => _body()),
    );
  }

  SafeArea _body() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 24, 12, 12),
        child: Column(
          spacing: 30,
          children: [
            const StyledText(
              'Click YT',
              textAlign: TextAlign.center,
              fontSize: 50,
              color: AppColors.accent,
            ),
            SearchField(
              controller: _urlController,
              onPressed: _searchFieldCallback,
            ),
          ],
        ),
      ),
    );
  }

  void _searchFieldCallback() {
    _latestUrl = null;
    if (_urlController.text.isEmpty) return;

    _processUrl();
  }

  Future<void> _processUrl() async {
    if (!YtDownloader.isYoutubeUrl(_urlController.text)) {
      AppSnackBar.error(context, 'Error, invalid Url');
    } else {
      unawaited(
        showDialog(context: context, builder: (_) => const LoadingDialog()),
      );

      try {
        var yt = YtDownloader.getManifest(_urlController.text);

        var videoInfo = await yt.getVideoInfo();
        if (mounted) Navigator.pop(context);
        if (mounted) {
          AppSnackBar.info(context, 'callate puto');
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            context: context,
            builder: (_) => DownloadModal(
              title: videoInfo.title,
              thumbnailUrl: videoInfo.thumbnailUrl,
              sizes: videoInfo.sizes,
              onPressed: _onDownloadPressed,
            ),
          );
        }
      } catch (e) {
        if (mounted) Navigator.pop(context);
        AppSnackBar.error(
          context,
          'Error al obtener informacion del video, $e',
        );
      } finally {
        _latestUrl = _urlController.text;
        setState(() => _urlController.clear());
      }
    }
  }

  void _onDownloadPressed() async {
    Navigator.pop(context);
    await _startDownload();
  }

  Future<void> _startDownload() async {
    try {
      final provider = Provider.of<DownloadProvider>(context, listen: false);
      await provider.startDownload(
        url: _latestUrl!,
        quality: VideoQualities.audio,
      );
      _urlController.clear();
    } catch (e) {
      AppSnackBar.error(context, 'Error: $e');
    }
  }
}
