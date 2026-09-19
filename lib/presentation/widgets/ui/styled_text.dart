import 'package:click_yt/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  final String _text;
  final double? _fontSize;
  final int? _maxLines;
  final TextOverflow? _overflow;
  final TextAlign? _textAlign;
  final Alignment _alignment;
  final Color _color;
  const new(
    this._text, {
    super.key,
    this._color = AppColors.foreground,
    this._fontSize,
    this._textAlign,
    this._maxLines,
    this._overflow,
    this._alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: _alignment,
      child: Text(
        _text,
        textAlign: _textAlign,
        overflow: _overflow,
        maxLines: _maxLines,
        style: TextStyle(fontSize: _fontSize, color: _color),
      ),
    );
  }
}
