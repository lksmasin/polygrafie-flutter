import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:polygrafie/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nastavení'),
      ),
      body: Column(
        children: [
          SwitchListTile(
            title: const Text('Tmavý režim'),
            value: themeProvider.themeMode == ThemeMode.dark,
            onChanged: (value) {
              themeProvider.toggleTheme(value);
            },
          ),
          ListTile(
            title: const Text('Primární barva'),
            trailing: DropdownButton<int>(
              value: themeProvider.primaryColor.value,
              items: [
                Colors.green.value,
                Colors.blue.value,
                Colors.orange.value,
                Colors.red.value,
                Colors.pink.value,
                Colors.purple.value,
              ].map((colorValue) {
                return DropdownMenuItem(
                  value: colorValue,
                  child: Container(
                    width: 24,
                    height: 24,
                    color: Color(colorValue),
                  ),
                );
              }).toList(),
              onChanged: (colorValue) {
                if (colorValue != null) {
                  themeProvider.updatePrimaryColor(Color(colorValue));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
