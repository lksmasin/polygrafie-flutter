import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Informace', style: TextStyle(fontWeight: FontWeight.w600)),
        elevation: 1,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        children: [
          Card(
            color: theme.colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline_rounded, size: 32, color: theme.colorScheme.onPrimaryContainer),
                      const SizedBox(width: 12),
                      Text(
                        'O aplikaci',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Tato aplikace nabízí různé polygrafické nástroje a kalkulačky, které ti pomohou s výpočty a převody v oblasti tisku a grafiky.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.8),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Divider(color: theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.2)),
                  const SizedBox(height: 8),
                  Text('Verze: 4.0.0', style: TextStyle(color: theme.colorScheme.onPrimaryContainer, fontWeight: FontWeight.w500)),
                  Text('Autor: Lukáš M. (LUKYMAS)', style: TextStyle(color: theme.colorScheme.onPrimaryContainer, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'Nápověda k nástrojům',
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildExpansionTile(
            context: context,
            icon: Icons.design_services,
            title: 'Počítání řezů',
            content: 'Nejvíce používaný nástroj. Používá se pro výpočet řezů. Zadáš velikost čistého formátu a tiskoviny, okraje a dvojřez. Po stisknutí "Vypočítat" se vypíší výsledky, které stačí zadat stroji na řezání.\n\nDVOJŘEZ je velikost mezi dvěma spadávkami na tiskovém archu (obvykle 4 mm)! Aplikace je chytřejší – nyní navíc hlídá logiku rozměrů i typické papírové formáty (A, B, SRA).',
          ),
          const SizedBox(height: 8),
          _buildExpansionTile(
            context: context,
            icon: Icons.grid_view_rounded,
            title: 'Užitek tiskového archu',
            content: 'Slouží k vypočítání užitku tiskového archu – jinými slovy kolik tiskovin se vejde na jeden čistý formát. Zadáš velikosti (velikost archu, tiskoviny, spadávky, netisknutelné oblasti) a požadovaný počet kusů. Aplikace spočítá varianty s otočením i bez něj, vybere tu lepší a sdělí ti potřebný počet archů.',
          ),
          const SizedBox(height: 8),
          _buildExpansionTile(
            context: context,
            icon: Icons.payments_outlined,
            title: 'Cena papíru',
            content: 'Nástroj pro výpočet celkové ceny nakupovaného papíru. Zadáš rozměry archu, plošnou hmotnost (gramáž v g/m²), množství (počet archů) a cenu za kilogram. Nástroj převede plochu a gramáž na hmotnost a přesně spočítá celkovou cenu.',
          ),
          const SizedBox(height: 8),
          _buildExpansionTile(
            context: context,
            icon: Icons.article_outlined,
            title: 'Formáty papírů',
            content: 'Přehledná tabulka všech nejpoužívanějších ISO formátů papíru. Najdeš zde přesné rozměry pro formátové řady A, B, C a také prodloužené tiskové formáty SRA a RA.',
          ),
        ],
      ),
    );
  }

  Widget _buildExpansionTile({required BuildContext context, required IconData icon, required String title, required String content}) {
    final theme = Theme.of(context);
    return Card(
      color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        leading: Icon(icon, color: theme.colorScheme.primary),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              content,
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
