import 'package:click_yt/presentation/providers/download_provider.dart';
import 'package:click_yt/presentation/widgets/home/search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../helpers/fake_download_history_repository.dart';
import '../helpers/fake_youtube_repository.dart';

void main() {
  late FakeYoutubeRepository youtube;
  late FakeDownloadHistoryRepository history;

  setUp(() {
    youtube = FakeYoutubeRepository();
    history = FakeDownloadHistoryRepository();
  });

  Widget buildApp() {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => Scaffold(
            body: SearchField(controller: TextEditingController()),
          ),
        ),
      ],
    );

    return ChangeNotifierProvider(
      create: (context) => DownloadProvider(
        youtubeRepository: youtube,
        historyRepository: history,
      ),
      child: MaterialApp.router(routerConfig: router),
    );
  }

  Future<void> submitUrl(WidgetTester tester, String url) async {
    await tester.enterText(find.byType(TextField), url);
    await tester.pump();
    await tester.testTextInput.receiveAction(TextInputAction.done);
  }

  testWidgets('URL inválida muestra un snackbar de error', (tester) async {
    await tester.pumpWidget(buildApp());

    await submitUrl(tester, 'no es una url');
    await tester.pump();

    expect(youtube.getVideoInfoCalls, 0);
    expect(find.text('FormatException: Invalid Url Link'), findsOneWidget);
    expect(find.byType(SnackBar), findsOneWidget);
  });

  testWidgets('URL válida consulta el video y abre el modal', (tester) async {
    await tester.pumpWidget(buildApp());

    await submitUrl(tester, 'https://youtu.be/dQw4w9WgXcQ');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(youtube.getVideoInfoCalls, 1);
    expect(find.text('Download'), findsNWidgets(2));
  });
}