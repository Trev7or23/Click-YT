import 'package:flutter/material.dart';

class AppNavigationBar extends StatelessWidget {
  final int _currentIndex;
  final ValueChanged<int> _onTap;
  final List<BottomNavigationBarItem> _items;
  const new({
    super.key,
    required this._currentIndex,
    required this._onTap,
    required this._items,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: _items,
      onTap: _onTap,
      currentIndex: _currentIndex,
    );
  }
}
