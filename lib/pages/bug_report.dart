import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:url_launcher/url_launcher.dart';

class BugReport extends StatelessWidget {
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
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nahlášení chyby',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Pokud narazíte na chybu nebo problém, můžete ji nahlásit na GitHubu. Pomůžete nám tak aplikaci vylepšovat.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: null,
              child: Text('Otevřít GitHub Issues'),
            ),
          ],
        ),
      ),
    );
  }
}
