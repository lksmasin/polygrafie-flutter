import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BugReport extends StatelessWidget {
  const BugReport({super.key});

  static const String githubUrl = 'https://github.com/lksmasin/polygrafie-flutter/issues';

  static Future<void> _launchUrl() async {
    final Uri url = Uri.parse(githubUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Nelze otevřít URL: $githubUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nahlásit chybu'),
        elevation: 1,
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
              'Pokud narazíš na chybu nebo problém, můžeš ji nahlásit na GitHubu. Pumůžeš mi tak aplikaci vylepšovat.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Nebo mi napiš na instagram @lukymas_',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _launchUrl,
              child: Text('Otevřít GitHub Issues'),
            ),
          ],
        ),
      ),
    );
  }
}
