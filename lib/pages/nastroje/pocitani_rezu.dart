import 'package:flutter/material.dart';

class PocitaniRezu extends StatefulWidget {
  const PocitaniRezu({super.key});

  @override
  _PocitaniRezuState createState() => _PocitaniRezuState();
}

class _PocitaniRezuState extends State<PocitaniRezu> {
  final _formKey = GlobalKey<FormState>();

  // TextEditingController pro každé pole
  final TextEditingController _sirkaFormatuController = TextEditingController();
  final TextEditingController _vyskaFormatuController = TextEditingController();
  final TextEditingController _sirkaTiskovinyController = TextEditingController();
  final TextEditingController _vyskaTiskovinyController = TextEditingController();
  final TextEditingController _okrajLevyController = TextEditingController();
  final TextEditingController _okrajHorniController = TextEditingController();
  final TextEditingController _spadavkaController = TextEditingController();

  List<String> levyRezyList = [];
  List<String> horniRezyList = [];

  void _calculate() {
    // Ověří, zda je formulář validní
    if (_formKey.currentState?.validate() ?? false) {
      int sirkaFormatu = _parseInput(_sirkaFormatuController.text);
      int vyskaFormatu = _parseInput(_vyskaFormatuController.text);
      int sirkaTiskoviny = _parseInput(_sirkaTiskovinyController.text);
      int vyskaTiskoviny = _parseInput(_vyskaTiskovinyController.text);
      int okrajLevy = _parseInput(_okrajLevyController.text);
      int okrajHorni = _parseInput(_okrajHorniController.text);
      int spadavka = _parseInput(_spadavkaController.text);

      setState(() {
        levyRezyList = levyRezy(sirkaFormatu, sirkaTiskoviny, okrajLevy, spadavka);
        horniRezyList = horniRezy(vyskaFormatu, vyskaTiskoviny, okrajHorni, spadavka);
      });
    }
  }

  // Kontrola prázdných hodnot
  int _parseInput(String input) {
    if (input.isEmpty) {
      return 0; // Pokud je pole prázdné použij 0
    }
    return int.tryParse(input) ?? 0; // Pokud hodnota nejde převést použij 0
  }

  List<String> levyRezy(int sirkaFormatu, int sirkaTiskoviny, int okrajLevy, int spadavka) {
    List<String> rezy = [];
    int poziceRezu = sirkaFormatu - okrajLevy;

    while (poziceRezu >= sirkaTiskoviny) {
      rezy.add('Řez: $poziceRezu');
      poziceRezu -= sirkaTiskoviny;
      if (poziceRezu >= sirkaTiskoviny) {
        rezy.add('Řez: $poziceRezu');
      }
      poziceRezu -= spadavka;
    }

    // Otočit a Poslední řez
    rezy.add('Otočit');
    rezy.add('Řez: $sirkaTiskoviny');
    return rezy;
  }

  List<String> horniRezy(int vyskaFormatu, int vyskaTiskoviny, int okrajHorni, int spadavka) {
    List<String> rezy = [];
    int poziceRezu = vyskaFormatu - okrajHorni;

    while (poziceRezu >= vyskaTiskoviny) {
      rezy.add('Řez: $poziceRezu');
      poziceRezu -= vyskaTiskoviny;
      if (poziceRezu >= vyskaTiskoviny) {
        rezy.add('Řez: $poziceRezu');
      }
      poziceRezu -= spadavka;
    }

    // Otočit a Poslední řez
    rezy.add('Otočit');
    rezy.add('Řez: $vyskaTiskoviny');
    return rezy;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text('Počítání řezů'), elevation: 1,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 10),
                _buildTextField('Šířka formátu', _sirkaFormatuController),
                _buildTextField('Výška formátu', _vyskaFormatuController),
                _buildTextField('Šířka tiskoviny', _sirkaTiskovinyController),
                _buildTextField('Výška tiskoviny', _vyskaTiskovinyController),
                _buildTextField('Levý okraj', _okrajLevyController),
                _buildTextField('Horní okraj', _okrajHorniController),
                _buildTextField('Spadavka', _spadavkaController),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _calculate,
                  child: const Text('Spočítat'),
                ),
                const SizedBox(height: 20),
                // Oddělení sekce výsledku
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainer, // Dynamická barva
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildResult('Řezy z levé strany', levyRezyList),
                      const SizedBox(height: 20),
                      _buildResult('Řezy z horní strany', horniRezyList),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label, border: const OutlineInputBorder(), suffixText: "mm"),
        autofocus: true,
        keyboardType: TextInputType.number, // Pouze čísla
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Prosím zadej hodnotu';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildResult(String title, List<String> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 22, // Zvýraznění nadpisu
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Divider(thickness: 1.5), // Oddělení nadpisu
        for (var i = 0; i < data.length; i++)
          ListTile(
            title: Text('${i + 1}. ${data[i]}'),
          ),
      ],
    );
  }
}
