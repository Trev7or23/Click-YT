import 'package:click_yt/core/router/app_router.dart';
import 'package:click_yt/core/themes/app_theme.dart';
import 'package:click_yt/data/repositories/shared_preferences_download_history_repository.dart';
import 'package:click_yt/data/repositories/youtube_download_repository.dart';
import 'package:click_yt/presentation/providers/download_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DownloadProvider(
            youtubeRepository: YoutubeDownloadRepository(),
            historyRepository: SharedPreferencesDownloadHistoryRepository(),
          ),
        ),
      ],
      child: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        child: MaterialApp.router(
          routerConfig: appRouter,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.darkTheme,
        ),
      ),
    );
  }
}