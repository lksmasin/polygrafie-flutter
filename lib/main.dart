// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:polygrafie/pages/home.dart';
import 'package:polygrafie/pages/informace.dart';
import 'package:polygrafie/pages/nastaveni.dart';
import 'package:provider/provider.dart';
import 'package:polygrafie/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeProvider = ThemeProvider();
  await themeProvider.loadPreferences();
  
  runApp(
    ChangeNotifierProvider(
      create: (_) => themeProvider,
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
      title: "Polygrafické nástroje",
      themeMode: themeProvider.themeMode,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: themeProvider.primaryColor,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: themeProvider.primaryColor,
          brightness: Brightness.dark,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentPage = 0;
  
  final screens = [
    const HomePage(),
    const InfoPage(),
    const SettingsPage(),
  ];

  @override
  void initState() {
    super.initState();
    // Zobrazí SnackBar ihned po spuštění aplikace
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 15),
          backgroundColor: Theme.of(context).colorScheme.errorContainer,
          content: const Text('Využívej s dovolením vyučujícího!', style: TextStyle(color: Colors.white)),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentPage],
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Domů"),
          NavigationDestination(icon: Icon(Icons.info), label: "Informace"),
          NavigationDestination(icon: Icon(Icons.settings), label: "Nastavení"),
        ],
        onDestinationSelected: (int index) {
          HapticFeedback.selectionClick();
          setState(() {
            currentPage = index;
          });
        },
        selectedIndex: currentPage,
      ),
    );
  }
}
