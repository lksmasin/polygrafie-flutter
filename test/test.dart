import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: themeProvider.themeMode,
      theme: ThemeData(
        colorSchemeSeed: themeProvider.primaryColor, // Primární barva
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: themeProvider.primaryColor, // Primární barva pro tmavý režim
        brightness: Brightness.dark,
      ),
      home: const HomeScreen(),
    );
  }
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  Color _primaryColor = Colors.blue;

  ThemeMode get themeMode => _themeMode;
  Color get primaryColor => _primaryColor;

  Future<void> toggleTheme(bool isDarkMode) async {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', isDarkMode);
  }

  Future<void> updatePrimaryColor(Color color) async {
    _primaryColor = color;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('primaryColor', color.value);
  }

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _themeMode = prefs.getBool('isDarkMode') == true ? ThemeMode.dark : ThemeMode.light;
    _primaryColor = Color(prefs.getInt('primaryColor') ?? Colors.blue.value);
    notifyListeners();
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
            trailing: DropdownButton<Color>(
              value: themeProvider.primaryColor,
              items: [
                Colors.blue,
                Colors.red,
                Colors.green,
              ].map((color) {
                return DropdownMenuItem(
                  value: color,
                  child: Container(
                    width: 24,
                    height: 24,
                    color: color,
                  ),
                );
              }).toList(),
              onChanged: (color) {
                if (color != null) {
                  themeProvider.updatePrimaryColor(color);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
