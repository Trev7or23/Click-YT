import 'package:flutter/material.dart';

class AppSettingsPage extends StatelessWidget {
  static const name = 'settings_screen';

  const AppSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const Center(child: Placeholder()),
    );
  }
}