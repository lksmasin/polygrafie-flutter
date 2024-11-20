import 'package:flutter/material.dart';

class PoctCenyPap extends StatefulWidget {
  const PoctCenyPap({super.key});

  @override
  _PoctCenyPapState createState() => _PoctCenyPapState();
}

class _PoctCenyPapState extends State<PoctCenyPap> {
  final TextEditingController widthController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController sheetsController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  String totalPrice = '';

  void calculatePrice() {
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
      totalPrice = calculatedPrice.toStringAsFixed(2); // Uloží cenu
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Výpočet ceny papíru'),
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: widthController,
              decoration: const InputDecoration(
                labelText: 'Šířka tiskového archu',
                border: OutlineInputBorder(),
                suffixText: "mm",
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: heightController,
              decoration: const InputDecoration(
                labelText: 'Výška tiskového archu',
                border: OutlineInputBorder(),
                suffixText: "mm",
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: weightController,
              decoration: const InputDecoration(
                labelText: 'Plošná hmotnost',
                border: OutlineInputBorder(),
                suffixText: "g/m²",
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: sheetsController,
              decoration: const InputDecoration(
                labelText: 'Počet tiskových archů',
                border: OutlineInputBorder(),
                suffixText: "ks",
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(
                labelText: 'Cena papíru',
                border: OutlineInputBorder(),
                suffixText: "Kč/Kg",
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: calculatePrice,
              child: const Text('Vypočítat cenu'),
            ),
            const SizedBox(height: 16),

            // Rozšířený container s výsledkem
            if (totalPrice.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainer, // Dynamická barva
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Výsledná cena",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(thickness: 1.5), // Oddělující čára
                    Text(
                      "$totalPrice Kč",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
