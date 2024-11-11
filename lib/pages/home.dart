import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:polygrafie/pages/bug_report.dart';
import 'package:polygrafie/pages/nastroje/pocitani_rezu.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Polygrafické nástroje'),
        elevation: 1,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.bug_report),
            tooltip: 'Nahlásit chybu',
            onPressed: () {
              HapticFeedback.lightImpact();
              Navigator.push(context, MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Nahlásit chybu'),
                    ),
                    body: BugReport(),
                  );
                },
              ));
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Zarovnání na levou stranu
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
          ),
          // Divider(),
          // Menu nástrojů
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.design_services),
                  title: const Text('Počítání řezů'),
                  onTap: () {
                    // Otevřete obrazovku pro počítání řezů
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PocitaniRezu(), // Použijte třídu PocitaniRezu
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.calculate),
                  title: const Text('Počítání užitku tisk. archů'),
                  onTap: () {
/*                     Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PocitaniRezu(), // Použijte třídu PocitaniRezu
                      ),
                    ); */
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.functions),
                  title: const Text('Počítání ceny papíru'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.article),
                  title: const Text('Formáty papírů'),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
