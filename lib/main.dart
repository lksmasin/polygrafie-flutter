import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:polygrafie/pages/home.dart';
import 'package:polygrafie/pages/informace.dart';
import 'package:polygrafie/pages/nastaveni.dart';
import 'package:provider/provider.dart';
import 'package:polygrafie/ChangeNotifier.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Polygrafické nástroje',
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: themeProvider.primaryColor,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: themeProvider.primaryColor,
          ),
          themeMode: themeProvider.themeMode,
          debugShowCheckedModeBanner: false,
          home: const RootPage()
        );
      },
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
    SettingsPage(),
  ];

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
        onDestinationSelected: (int index){
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