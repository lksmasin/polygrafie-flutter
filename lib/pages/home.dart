import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0, // Skryje AppBar
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Zarovnání na levou stranu
        children: [
          // První řádek s tlačítky zarovnaný vlevo
          Padding(
            padding: const EdgeInsets.all(8.0),
          ),
          //Divider(),
          // Menu nástrojů
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.design_services),
                  title: const Text('Počítání řezů'),
                  onTap: () {
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.calculate),
                  title: const Text('Počítání užitku tisk. archů'),
                  onTap: () {
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.functions),
                  title: const Text('Počítání ceny papíru'),
                  onTap: () {
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.article),
                  title: const Text('Formáty papírů'),
                  onTap: () {
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
