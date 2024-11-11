import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:polygrafie/ChangeNotifier.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nastavení'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Vyberte téma:', style: TextStyle(fontSize: 18)),
            ListTile(
              title: const Text('Světlý režim'),
              leading: Radio(
                value: ThemeMode.light,
                groupValue: themeProvider.themeMode,
                onChanged: (ThemeMode? mode) {
                  themeProvider.setThemeMode(mode!);
                },
              ),
            ),
            ListTile(
              title: const Text('Tmavý režim'),
              leading: Radio(
                value: ThemeMode.dark,
                groupValue: themeProvider.themeMode,
                onChanged: (ThemeMode? mode) {
                  themeProvider.setThemeMode(mode!);
                },
              ),
            ),
            ListTile(
              title: const Text('Systémový režim'),
              leading: Radio(
                value: ThemeMode.system,
                groupValue: themeProvider.themeMode,
                onChanged: (ThemeMode? mode) {
                  themeProvider.setThemeMode(mode!);
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text('Vyberte výchozí barvu:', style: TextStyle(fontSize: 18)),
            Wrap(
              spacing: 10,
              children: Colors.primaries.map((color) {
                return GestureDetector(
                  onTap: () {
                    themeProvider.setPrimaryColor(color);
                  },
                  child: CircleAvatar(
                    backgroundColor: color,
                    radius: 20,
                    child: themeProvider.primaryColor == color
                        ? const Icon(Icons.check, color: Colors.white)
                        : null,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
