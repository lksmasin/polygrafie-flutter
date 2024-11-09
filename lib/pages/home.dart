import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Polygrafické nástroje"),
        backgroundColor: Colors.lightGreen,
        elevation: 1,
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Domů",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Nastavení",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: "Informace",
          ),
        ],
      ),
    );
  }
}