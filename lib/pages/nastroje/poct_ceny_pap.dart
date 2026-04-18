import 'package:flutter/material.dart';

class PoctCenyPap extends StatefulWidget {
  const PoctCenyPap({super.key});

  @override
  _PoctCenyPapState createState() => _PoctCenyPapState();
}

class _PoctCenyPapState extends State<PoctCenyPap> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController widthController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController sheetsController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  String totalPrice = '';
  String detailedSteps = '';

  void _clearAll() {
    setState(() {
      widthController.clear();
      heightController.clear();
      weightController.clear();
      sheetsController.clear();
      priceController.clear();
      totalPrice = '';
      detailedSteps = '';
    });
  }

  void calculatePrice() {
    if (_formKey.currentState?.validate() ?? false) {
      final double width = double.tryParse(widthController.text) ?? 0;
      final double height = double.tryParse(heightController.text) ?? 0;
      final double weight = double.tryParse(weightController.text) ?? 0;
      final double sheets = double.tryParse(sheetsController.text) ?? 0;
      final double price = double.tryParse(priceController.text) ?? 0;

      final double area = (width / 1000) * (height / 1000); // m²
      final double totalArea = area * sheets; // Total area in m²
      final double totalWeight = totalArea * weight / 1000; // Total weight in kg
      final double calculatedPrice = totalWeight * price;

      setState(() {
        totalPrice = calculatedPrice.toStringAsFixed(2);
        detailedSteps = '''
Postup výpočtu:

1. Plocha jednoho archu
   (${width / 1000} m × ${height / 1000} m) = ${area.toStringAsFixed(4)} m²

2. Celková plocha (${sheets.toInt()} archů)
   ${area.toStringAsFixed(4)} m² × ${sheets.toInt()} = ${totalArea.toStringAsFixed(4)} m²

3. Celková hmotnost
   (${totalArea.toStringAsFixed(4)} m² × $weight g/m²) / 1000 = ${totalWeight.toStringAsFixed(4)} kg

4. Výsledná cena
   ${totalWeight.toStringAsFixed(4)} kg × $price Kč/kg = ${calculatedPrice.toStringAsFixed(2)} Kč
''';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Výpočet ceny papíru'),
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
              _buildTextField('Šířka tiskového archu', widthController, 'mm', Icons.straighten, autofocus: true),
              _buildTextField('Výška tiskového archu', heightController, 'mm', Icons.height),
              const SizedBox(height: 8),
              Text(
                'Parametry papíru',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildTextField('Plošná hmotnost', weightController, 'g/m²', Icons.scale),
              _buildTextField('Počet tiskových archů', sheetsController, 'ks', Icons.layers),
              _buildTextField('Cena papíru', priceController, 'Kč/Kg', Icons.payments_outlined, isLast: true),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: calculatePrice,
                icon: const Icon(Icons.calculate_outlined),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                label: const Text('Vypočítat cenu'),
              ),
              const SizedBox(height: 24),
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: totalPrice.isNotEmpty
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
                              Center(
                                child: Text(
                                  "Výsledná cena",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Center(
                                child: Text(
                                  "$totalPrice Kč",
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              Divider(color: Theme.of(context).colorScheme.outlineVariant),
                              const SizedBox(height: 16),
                              Text(
                                detailedSteps,
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
          if (n <= 0) {
            return 'Hodnota musí být větší než 0';
          }
          return null;
        },
      ),
    );
  }
}
