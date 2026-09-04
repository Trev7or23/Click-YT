import 'package:click_yt/config/themes/app_colors.dart';
import 'package:click_yt/config/themes/text_styles.dart';
import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final VoidCallback? onPressed;
  final TextEditingController _controller;

  const SearchField({super.key, this.onPressed, required this._controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.white),

      controller: _controller,
      onSubmitted: (_) => _onSubmitted(),

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
            onPressed: () => _onSubmitted(),
            icon: const Icon(Icons.search, size: 30, semanticLabel: 'Search'),
          ),
        ),
      ),
    );
  }

  void _onSubmitted() => onPressed?.call();

  void dispose() {
    _controller.dispose();
  }
}
