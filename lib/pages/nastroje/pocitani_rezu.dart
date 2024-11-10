import 'package:flutter/material.dart';

class PocitaniRezu extends StatefulWidget {
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
    // Pokud některé pole není vyplněno, použije se výchozí hodnota 0
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

  // Funkce pro převod textu na číslo a kontrolu prázdných hodnot
  int _parseInput(String input) {
    if (input.isEmpty) {
      return 0; // Pokud je pole prázdné, použije se 0
    }
    return int.tryParse(input) ?? 0; // Pokud se hodnota nedá převést, použije se 0
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

    // Přidáme "Otočit" a "Poslední řez"
    rezy.add('Otočit');
    rezy.add('Poslední řez: $sirkaTiskoviny');
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

    // Přidáme "Otočit" a "Poslední řez"
    rezy.add('Otočit');
    rezy.add('Poslední řez: $vyskaTiskoviny');
    return rezy;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Počítání řezů')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildTextField('Šířka formátu', _sirkaFormatuController),
                _buildTextField('Výška formátu', _vyskaFormatuController),
                _buildTextField('Šířka tiskoviny', _sirkaTiskovinyController),
                _buildTextField('Výška tiskoviny', _vyskaTiskovinyController),
                _buildTextField('Levý okraj', _okrajLevyController),
                _buildTextField('Horní okraj', _okrajHorniController),
                _buildTextField('Spadavka', _spadavkaController),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _calculate,
                  child: Text('Spočítat'),
                ),
                SizedBox(height: 20),
                _buildResult('Levé řezy', levyRezyList),
                SizedBox(height: 20),
                _buildResult('Horní řezy', horniRezyList),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
        keyboardType: TextInputType.number, // Povolení pouze čísel
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Prosím zadejte hodnotu';
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
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        for (var i = 0; i < data.length; i++)
          ListTile(
            title: Text('${i + 1}. ${data[i]}'),
          ),
      ],
    );
  }
}
