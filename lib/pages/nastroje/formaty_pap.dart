import 'package:flutter/material.dart';

class FormatyPap extends StatefulWidget {
  const FormatyPap({super.key});

  @override
  _FormatyPapState createState() => _FormatyPapState();
}

class _FormatyPapState extends State<FormatyPap> {

  Widget buildTable(String title, List<List<String>> data, List<String> headers) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Table(
          border: TableBorder.all(color: Colors.white70 ),
          columnWidths: {
            for (int i = 0; i < headers.length; i++) i: const FlexColumnWidth()
          },
          children: [
            TableRow(
              children: headers
                  .map((header) => Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(header, textAlign: TextAlign.center),
                      ))
                  .toList(),
            ),
            ...data.map(
              (row) => TableRow(
                children: row
                    .map((cell) => Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(cell, textAlign: TextAlign.center),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Velikosti papírů'),
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTable(
                'Řady A, B, C',
                [
                  ['0', '841 × 1189', '1000 × 1414', '917 × 1297'],
                  ['1', '594 × 841', '707 × 1000', '648 × 917'],
                  ['2', '420 × 594', '500 × 707', '458 × 648'],
                  ['3', '297 × 420', '353 × 500', '324 × 458'],
                  ['4', '210 × 297', '250 × 353', '229 × 324'],
                  ['5', '148 × 210', '176 × 250', '162 × 229'],
                  ['6', '105 × 148', '125 × 176', '114 × 162'],
                  ['7', '74 × 105', '88 × 125', '81 × 114'],
                  ['8', '52 × 74', '62 × 88', '57 × 81'],
                  ['9', '37 × 52', '44 × 62', '40 × 57'],
                  ['10', '26 × 37', '31 × 44', '28 × 40'],
                ],
                ['Velikost', 'Formát A', 'Formát B', 'Formát C'],
              ),
              buildTable(
                'Řada SRA',
                [
                  ['SRA0', '900 × 1280'],
                  ['SRA1', '640 × 900'],
                  ['SRA2', '450 × 640'],
                  ['SRA3', '320 × 450'],
                  ['SRA4', '225 × 320'],
                ],
                ['SRA Velikost', 'Rozměry (mm)'],
              ),
              buildTable(
                'Řada RA',
                [
                  ['RA0', '860 × 1220'],
                  ['RA1', '610 × 860'],
                  ['RA2', '430 × 610'],
                  ['RA3', '305 × 430'],
                  ['RA4', '215 × 305'],
                ],
                ['RA Velikost', 'Rozměry (mm)'],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
