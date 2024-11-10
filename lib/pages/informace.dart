import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informace'),
        elevation: 1,
      ),
      body: const SingleChildScrollView( // Přidání scrollování
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'O aplikaci',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Tato aplikace nabízí různé polygrafické nástroje a kalkulačky, které ti pomohou s výpočty a převody v oblasti tisku a grafiky.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Verze: 0',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Autor: Lukáš M. (LUKYMAS)',
              style: TextStyle(fontSize: 16),
            ),
            Divider(),
            SizedBox(height: 20),
            Text(
              'Nástroj "Počítání řezů"',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Asi nejíce používaný nástroj. Používá se pro výpočet řezů. Zadáš velikost čistého formátu a tiskoviny, okraje, spadávky a po stisknutí vypočítat se vypíší výsledky které stačí zadat stroji na řezání.',
              style: TextStyle(fontSize: 16),
            ),
            Divider(),
            SizedBox(height: 20),
            Text(
              'Nástroj "Počítání užitku tiskového archu"',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Slouží pro vypočítání užitku tiskového archu, jinými slovy kolik se vejde tiskoviny na ČF. Zadáš velikosti (jako je velikost ČF a Tisk., velikost spadávky, okrajů) a další. Následně se provedou kalkulace.',
              style: TextStyle(fontSize: 16),
            ),
            Divider(),
            SizedBox(height: 20),
            Text(
              'Nástroj "Počítání ceny papíru"',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Slouží pro vypočítání ceny papíru. Zadáš množstvý, gramáž cenu atd.',
              style: TextStyle(fontSize: 16),
            ),
            Divider(),
            SizedBox(height: 20),
            Text(
              'Nástroj "Formáty papírů"',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Ukáže ti všechny nejpoužívanější formáty papíru. Řady A, B, C, SRA..',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
