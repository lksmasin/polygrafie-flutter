import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:polygrafie/pages/bug_report.dart';
import 'package:polygrafie/pages/nastroje/formaty_pap.dart';
import 'package:polygrafie/pages/nastroje/pocitani_rezu.dart';
import 'package:polygrafie/pages/nastroje/poct_ceny_pap.dart';
import 'package:polygrafie/pages/nastroje/poct_uzit_tisk_arch.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Polygrafické nástroje',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.bug_report_outlined),
            tooltip: 'Nahlásit chybu',
            onPressed: () {
              HapticFeedback.heavyImpact();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BugReport(),
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Vítejte,',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Vyberte nástroj z nabídky níže.',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                _buildToolCard(
                  context: context,
                  title: 'Počítání řezů',
                  subtitle: 'Výpočet řezů tiskoviny s ohledem na spadávku a okraje.',
                  icon: Icons.design_services,
                  destination: const PocitaniRezu(),
                ),
                _buildToolCard(
                  context: context,
                  title: 'Užitek tiskového archu',
                  subtitle: 'Kalkulace, kolik tiskovin se vejde na jeden arch.',
                  icon: Icons.grid_view_rounded,
                  destination: const PocitaniUzitkuTiskArchu(),
                ),
                _buildToolCard(
                  context: context,
                  title: 'Cena papíru',
                  subtitle: 'Výpočet konečné ceny na základě formátu a gramáže.',
                  icon: Icons.payments_outlined,
                  destination: const PoctCenyPap(),
                ),
                _buildToolCard(
                  context: context,
                  title: 'Formáty papírů',
                  subtitle: 'Rychlý přehled ISO rozměrů (A, B, C, SRA, RA).',
                  icon: Icons.article_outlined,
                  destination: const FormatyPap(),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Widget destination,
  }) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Card(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => destination),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    size: 28,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
