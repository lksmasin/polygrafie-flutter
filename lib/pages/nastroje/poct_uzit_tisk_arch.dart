import 'package:flutter/material.dart';

class PocitaniUzitkuTiskArchu extends StatefulWidget {
  const PocitaniUzitkuTiskArchu({super.key});

  @override
  _PocitaniUzitkuTiskArchuState createState() => _PocitaniUzitkuTiskArchuState();
}

class _PocitaniUzitkuTiskArchuState extends State<PocitaniUzitkuTiskArchu> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController archWidthController = TextEditingController();
  final TextEditingController archHeightController = TextEditingController();
  final TextEditingController tiskovinaWidthController = TextEditingController();
  final TextEditingController tiskovinaHeightController = TextEditingController();
  final TextEditingController spadController = TextEditingController();
  final TextEditingController netiskOblastController = TextEditingController();
  final TextEditingController countController = TextEditingController();

  String shortResult = '';
  String detailedResult = '';
  bool showResults = false;

  void _clearAll() {
    setState(() {
      archWidthController.clear();
      archHeightController.clear();
      tiskovinaWidthController.clear();
      tiskovinaHeightController.clear();
      spadController.clear();
      netiskOblastController.clear();
      countController.clear();
      shortResult = '';
      detailedResult = '';
      showResults = false;
    });
  }

  void calculate() {
    if (_formKey.currentState?.validate() ?? false) {
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

      if (maxUsitky <= 0) {
        setState(() {
          shortResult = 'Tiskovina je větší než tiskový arch!';
          detailedResult = 'Nelze umístit ani jeden užitek na arch.';
          showResults = true;
        });
        return;
      }

      // 6. Výpočet potřebného počtu archů
      final int totalArchs = (count / maxUsitky).ceil();

      // Formátování čísel
      String formatNumber(double value) =>
          value % 1 == 0 ? value.toInt().toString() : value.toStringAsFixed(2);

      setState(() {
        shortResult = 'Potřebný počet archů: $totalArchs';
        detailedResult = '''
Postup výpočtu:

1. Výpočet efektivní plochy tiskového archu (TA)
   - Odečtení netisknutelné oblasti (${formatNumber(netiskOblast)} mm z každé strany)
   - Efektivní TA: ${formatNumber(archWidthEffective)} × ${formatNumber(archHeightEffective)} mm

2. Výpočet potřebné plochy pro jednu tiskovinu
   - Přičtení spadávky (${formatNumber(spad)} mm z každé strany)
   - Tiskovina se spadem: ${formatNumber(tiskovinaWidthWithSpad)} × ${formatNumber(tiskovinaHeightWithSpad)} mm

3. Zjištění počtu užitků
   - Varianta A (bez otočení): $usitkyWidth1 sloupců × $usitkyHeight1 řad = $usitky1 užitků
   - Varianta B (s otočením): $usitkyWidth2 sloupců × $usitkyHeight2 řad = $usitky2 užitků

4. Závěr
   - Vybrána efektivnější varianta s $maxUsitky užitky na jeden arch.
   - Pro požadovaných $count kusů je tedy potřeba celkem $totalArchs archů.
        ''';
        showResults = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Výpočet užitku archu'),
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _clearAll,
            tooltip: 'Vymazat vše',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Rozměry',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildTextField('Šířka archu', archWidthController, 'mm', Icons.straighten, autofocus: true),
              _buildTextField('Výška archu', archHeightController, 'mm', Icons.height),
              _buildTextField('Šířka tiskoviny', tiskovinaWidthController, 'mm', Icons.crop_free),
              _buildTextField('Výška tiskoviny', tiskovinaHeightController, 'mm', Icons.crop_free),
              const SizedBox(height: 8),
              Text(
                'Parametry',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildTextField('Spadávka', spadController, 'mm', Icons.content_cut),
              _buildTextField('Netisknutelná oblast', netiskOblastController, 'mm', Icons.border_outer),
              _buildTextField('Počet celkem', countController, 'ks', Icons.tag, isLast: true),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: calculate,
                icon: const Icon(Icons.calculate_outlined),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                label: const Text('Vypočítat'),
              ),
              const SizedBox(height: 24),
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: showResults
                    ? Card(
                        elevation: 0,
                        color: Theme.of(context).colorScheme.surfaceContainerHighest,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                shortResult,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Divider(color: Theme.of(context).colorScheme.outlineVariant),
                              const SizedBox(height: 16),
                              Text(
                                detailedResult,
                                style: const TextStyle(fontSize: 15, height: 1.6),
                              ),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, String suffix, IconData icon, {bool autofocus = false, bool isLast = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Theme.of(context).colorScheme.primary),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
          ),
          suffixText: suffix,
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
        ),
        autofocus: autofocus,
        keyboardType: TextInputType.number,
        textInputAction: isLast ? TextInputAction.done : TextInputAction.next,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Zadejte hodnotu';
          }
          final n = double.tryParse(value);
          if (n == null) {
            return 'Zadejte platné číslo';
          }
          if (n < 0) {
            return 'Hodnota nesmí být záporná';
          }
          return null;
        },
      ),
    );
  }
}
