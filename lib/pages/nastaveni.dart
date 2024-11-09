import 'package:flutter/material.dart';
//import 'package:adaptive_theme/adaptive_theme.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nastavení'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: const Text('Tmavý režim'),
              value: false,
              onChanged: (value) {
                //AdaptiveTheme.of(context).toggleThemeMode();
              },
            ),
          ],
        ),
      ),
    );
  }
}
