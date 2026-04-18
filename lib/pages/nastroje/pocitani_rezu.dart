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
  final TextEditingController _spadavkaController = TextEditingController(text: '4'); // Default dvojřez = 4

  List<String> levyRezyList = [];
  List<String> horniRezyList = [];
  String? errorMessage;
  List<String> warningMessages = [];
  bool showResults = false;

  void _clearAll() {
    setState(() {
      _sirkaFormatuController.clear();
      _vyskaFormatuController.clear();
      _sirkaTiskovinyController.clear();
      _vyskaTiskovinyController.clear();
      _okrajLevyController.clear();
      _okrajHorniController.clear();
      _spadavkaController.text = '4'; // Reset na default
      levyRezyList = [];
      horniRezyList = [];
      errorMessage = null;
      warningMessages = [];
      showResults = false;
    });
  }

  void _calculate() {
    if (_formKey.currentState?.validate() ?? false) {
      int sirkaFormatu = _parseInput(_sirkaFormatuController.text);
      int vyskaFormatu = _parseInput(_vyskaFormatuController.text);
      int sirkaTiskoviny = _parseInput(_sirkaTiskovinyController.text);
      int vyskaTiskoviny = _parseInput(_vyskaTiskovinyController.text);
      int okrajLevy = _parseInput(_okrajLevyController.text);
      int okrajHorni = _parseInput(_okrajHorniController.text);
      int spadavka = _parseInput(_spadavkaController.text);

      String? error;
      List<String> warnings = [];

      // Validace standardních rozměrů
      final Set<String> standardArch = {
        '1000x1414', '707x1000', '500x707', '353x500', '250x353', '176x250', '125x176', '88x125', '62x88', '44x62', '31x44', // Rada B
        '900x1280', '640x900', '450x640', '320x450', '225x320' // Rada SRA
      };
      final Set<String> standardTiskovina = {
        '841x1189', '594x841', '420x594', '297x420', '210x297', '148x210', '105x148', '74x105', '52x74', '37x52', '26x37' // Rada A
      };

      if (!standardArch.contains('${sirkaFormatu}x$vyskaFormatu') && !standardArch.contains('${vyskaFormatu}x$sirkaFormatu')) {
        warnings.add('Upozornění: Zadaný formát archu neodpovídá běžným rozměrům řady B ani SRA.');
      }
      if (!standardTiskovina.contains('${sirkaTiskoviny}x$vyskaTiskoviny') && !standardTiskovina.contains('${vyskaTiskoviny}x$sirkaTiskoviny')) {
        warnings.add('Upozornění: Zadaný rozměr tiskoviny neodpovídá běžným rozměrům řady A.');
      }

      // Výpočet počtu užitků
      int pocetSirka = 0;
      int tempPoziceS = sirkaFormatu - okrajLevy;
      while (tempPoziceS >= sirkaTiskoviny) {
        pocetSirka++;
        tempPoziceS -= sirkaTiskoviny;
        tempPoziceS -= spadavka;
      }

      int pocetVyska = 0;
      int tempPoziceV = vyskaFormatu - okrajHorni;
      while (tempPoziceV >= vyskaTiskoviny) {
        pocetVyska++;
        tempPoziceV -= vyskaTiskoviny;
        tempPoziceV -= spadavka;
      }

      // Validace, zda se to vůbec na papír vejde
      if (pocetSirka == 0 || pocetVyska == 0) {
        error = 'Chyba: Tiskovina se zadanými okraji a spadávkou se na arch nevejde!';

        // Kontrola, zda by se nevešla po otočení
        int rotSirka = 0;
        int tempRotS = sirkaFormatu - okrajLevy;
        while (tempRotS >= vyskaTiskoviny) {
          rotSirka++;
          tempRotS -= vyskaTiskoviny;
          tempRotS -= spadavka;
        }

        int rotVyska = 0;
        int tempRotV = vyskaFormatu - okrajHorni;
        while (tempRotV >= sirkaTiskoviny) {
          rotVyska++;
          tempRotV -= sirkaTiskoviny;
          tempRotV -= spadavka;
        }

        if (rotSirka > 0 && rotVyska > 0) {
           error = 'Chyba: Tiskovina se v této orientaci na arch nevejde. Zkuste prohodit šířku a výšku tiskoviny.';
        }
      }

      setState(() {
        errorMessage = error;
        warningMessages = warnings;
        if (error == null) {
          levyRezyList = levyRezy(sirkaFormatu, sirkaTiskoviny, okrajLevy, spadavka);
          horniRezyList = horniRezy(vyskaFormatu, vyskaTiskoviny, okrajHorni, spadavka);
        } else {
          levyRezyList = [];
          horniRezyList = [];
        }
        showResults = true;
      });
    }
  }

  // Kontrola prázdných hodnot
  int _parseInput(String input) {
    if (input.isEmpty) {
      return 0;
    }
    return int.tryParse(input) ?? 0;
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
      appBar: AppBar(
        title: const Text('Počítání řezů'),
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _clearAll,
            tooltip: 'Vymazat vše',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
              Text(
                'Rozměry',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildTextField('Šířka formátu', _sirkaFormatuController, Icons.straighten, autofocus: true),
              _buildTextField('Výška formátu', _vyskaFormatuController, Icons.height),
              _buildTextField('Šířka tiskoviny', _sirkaTiskovinyController, Icons.crop_free),
              _buildTextField('Výška tiskoviny', _vyskaTiskovinyController, Icons.crop_free),
              const SizedBox(height: 8),
              Text(
                'Okraje a spadávka',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildTextField('Levý okraj', _okrajLevyController, Icons.space_bar),
              _buildTextField('Horní okraj', _okrajHorniController, Icons.space_bar),
              _buildTextField('Dvojřez (spadávka)', _spadavkaController, Icons.content_cut, isLast: true),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _calculate,
                icon: const Icon(Icons.calculate_outlined),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                label: const Text('Spočítat'),
              ),
              const SizedBox(height: 24),
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: showResults
                    ? Card(
                        elevation: 0,
                        color: errorMessage != null 
                            ? Theme.of(context).colorScheme.errorContainer 
                            : Theme.of(context).colorScheme.surfaceContainerHighest,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (errorMessage != null)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.error_outline, color: Theme.of(context).colorScheme.error),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    errorMessage!,
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.error,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          else ...[
                            if (warningMessages.isNotEmpty) ...[
                              for (var warning in warningMessages)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Icon(Icons.warning_amber_rounded, color: Colors.orange.shade600),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          warning,
                                          style: TextStyle(
                                            color: Colors.orange.shade600,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              const Divider(height: 12),
                              const SizedBox(height: 12),
                            ],
                            _buildResult('Řezy z levé strany', levyRezyList),
                            const SizedBox(height: 24),
                            _buildResult('Řezy z horní strany', horniRezyList),
                            const SizedBox(height: 16),
                            const Text(
                              '* Výpočet předpokládá fixní orientaci (Šířka na Šířku).',
                              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
                            ),
                          ],
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
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon, {bool autofocus = false, bool isLast = false}) {
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
          suffixText: "mm",
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
        ),
        autofocus: autofocus,
        keyboardType: TextInputType.number,
        textInputAction: isLast ? TextInputAction.done : TextInputAction.next,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Zadejte hodnotu v mm';
          }
          if (int.tryParse(value) == null) {
            return 'Zadejte platné celé číslo';
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
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const Divider(height: 24),
        if (data.isEmpty)
          const Text('Žádné řezy k zobrazení')
        else
          for (var i = 0; i < data.length; i++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 12,
                    child: Text('${i + 1}', style: const TextStyle(fontSize: 12)),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    data[i],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: data[i] == 'Otočit' ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
      ],
    );
  }
}
