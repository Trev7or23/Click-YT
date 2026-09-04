import 'package:click_yt/config/themes/app_colors.dart';
import 'package:click_yt/presentation/widgets/ui/styled_text.dart';
import 'package:flutter/material.dart';

class AppSnackBar {
  static void error(
    BuildContext context,
    String msg, {

    Duration duration = const Duration(seconds: 3),
  }) => _snackBar(context, msg, Colors.red, Icons.error);

  static void info(
    BuildContext context,
    String msg, {

    Duration duration = const Duration(seconds: 3),
  }) => _snackBar(context, msg, Colors.green, Icons.error);

  static void _snackBar(
    BuildContext context,
    String msg,
    Color color,
    IconData icon,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: const EdgeInsets.all(12),
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.backgroundComponent,
        content: Row(
          children: [
            Icon(icon, color: color, semanticLabel: 'Error Or info Icon'),
            const SizedBox(width: 10),
            Expanded(child: StyledText(msg, color: color)),
          ],
        ),
      ),
    );
  }
}
