import 'package:click_yt/core/themes/app_colors.dart';
import 'package:click_yt/presentation/widgets/home/search_field.dart';
import 'package:click_yt/presentation/widgets/ui/styled_text.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const name = 'home_screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            SearchField(controller: _urlController),
          ],
        ),
      ),
    );
  }
}
