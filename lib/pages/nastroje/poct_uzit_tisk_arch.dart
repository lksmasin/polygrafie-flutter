import 'package:flutter/material.dart';

class PocitaniUzitkuTiskArchu extends StatefulWidget {
  const PocitaniUzitkuTiskArchu({super.key});

  @override
  _PocitaniUzitkuTiskArchuState createState() => _PocitaniUzitkuTiskArchuState();
}

class _PocitaniUzitkuTiskArchuState extends State<PocitaniUzitkuTiskArchu> {
  final TextEditingController archWidthController = TextEditingController();
  final TextEditingController archHeightController = TextEditingController();
  final TextEditingController tiskovinaWidthController = TextEditingController();
  final TextEditingController tiskovinaHeightController = TextEditingController();
  final TextEditingController spadController = TextEditingController();
  final TextEditingController netiskOblastController = TextEditingController();
  final TextEditingController countController = TextEditingController();

  String shortResult = '';
  String detailedResult = '';

  void calculate() {
    // Získání hodnot z textových polí
    final double archWidth = double.tryParse(archWidthController.text) ?? 0;
    final double archHeight = double.tryParse(archHeightController.text) ?? 0;
    final double tiskovinaWidth = double.tryParse(tiskovinaWidthController.text) ?? 0;
    final double tiskovinaHeight = double.tryParse(tiskovinaHeightController.text) ?? 0;
    final double spad = double.tryParse(spadController.text) ?? 0;
    final double netiskOblast = double.tryParse(netiskOblastController.text) ?? 0;
    final int count = int.tryParse(countController.text) ?? 0;

    // 1. Odečtení netisknutelné oblasti
    final double archWidthEffective = archWidth - (2 * netiskOblast);
    final double archHeightEffective = archHeight - (2 * netiskOblast);

    // 2. Přičtení spadávky k rozměru tiskoviny
    final double tiskovinaWidthWithSpad = tiskovinaWidth + (2 * spad);
    final double tiskovinaHeightWithSpad = tiskovinaHeight + (2 * spad);

    // 3. Výpočet užitku (první způsob - tiskovina normálně)
    final int usitkyWidth1 = (archWidthEffective / tiskovinaWidthWithSpad).floor();
    final int usitkyHeight1 = (archHeightEffective / tiskovinaHeightWithSpad).floor();
    final int usitky1 = usitkyWidth1 * usitkyHeight1;

    // 4. Výpočet užitku (druhý způsob - tiskovina otočená)
    final int usitkyWidth2 = (archWidthEffective / tiskovinaHeightWithSpad).floor();
    final int usitkyHeight2 = (archHeightEffective / tiskovinaWidthWithSpad).floor();
    final int usitky2 = usitkyWidth2 * usitkyHeight2;

    // 5. Vybrání efektivnějšího způsobu
    final int maxUsitky = usitky1 > usitky2 ? usitky1 : usitky2;

    // 6. Výpočet potřebného počtu archů
    final int totalArchs = (count / maxUsitky).ceil();

    // Formátování čísel
    String formatNumber(double value) =>
        value % 1 == 0 ? value.toInt().toString() : value.toStringAsFixed(2);

    setState(() {
      shortResult = 'Potřebný počet archů: $totalArchs';
      detailedResult = '''
1. TA bez netisk. obl.: ${formatNumber(archWidthEffective)} x ${formatNumber(archHeightEffective)} mm
2. Tisk. se spadávkou: ${formatNumber(tiskovinaWidthWithSpad)} x ${formatNumber(tiskovinaHeightWithSpad)} mm

První způsob (tiskovina normálně):
  - Užitky na šířku: $usitkyWidth1
  - Užitky na výšku: $usitkyHeight1
  - Celkový počet užitků: $usitky1

Druhý způsob (tiskovina otočená):
  - Užitky na šířku: $usitkyWidth2
  - Užitky na výšku: $usitkyHeight2
  - Celkový počet užitků: $usitky2

Efektivnější způsob: $maxUsitky tiskovin na arch
Počet tiskových archů potřebných pro $count kusů: $totalArchs
      ''';
    });
  }

  void showDetailedResult() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Detailní výpočet'),
        content: SingleChildScrollView(
          child: Text(
            detailedResult,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Zavřít'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Výpočet užitku tiskového archu'),
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            _buildTextField('Šířka tiskového archu', archWidthController, 'mm'),
            _buildTextField('Výška tiskového archu', archHeightController, 'mm'),
            _buildTextField('Šířka tiskoviny', tiskovinaWidthController, 'mm'),
            _buildTextField('Výška tiskoviny', tiskovinaHeightController, 'mm'),
            _buildTextField('Spadávka', spadController, 'mm'),
            _buildTextField('Netisknutelná oblast', netiskOblastController, 'mm'),
            _buildTextField('Počet kusů', countController, 'ks'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculate,
              child: const Text('Vypočítat'),
            ),
            const SizedBox(height: 20),
            if (shortResult.isNotEmpty)
              GestureDetector(
                onTap: showDetailedResult,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        shortResult,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Kliknutím zobrazíš detailní výsledky',
                        style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, String suffix) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          suffixText: suffix,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
