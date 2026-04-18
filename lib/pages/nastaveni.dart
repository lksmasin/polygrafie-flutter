import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:polygrafie/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final theme = Theme.of(context);

    final List<Color> availableColors = [
      Colors.green,
      Colors.blue,
      Colors.orange,
      Colors.red,
      Colors.pink,
      Colors.purple,
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nastavení', style: TextStyle(fontWeight: FontWeight.w600)),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        children: [
          Text(
            'Vzhled',
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Card(
            color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
            child: SwitchListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              title: const Text('Tmavý režim', style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: const Text('Přepne aplikaci do tmavých barev'),
              secondary: Icon(
                themeProvider.themeMode == ThemeMode.dark 
                    ? Icons.dark_mode_rounded 
                    : Icons.light_mode_rounded,
                color: theme.colorScheme.primary,
              ),
              value: themeProvider.themeMode == ThemeMode.dark,
              onChanged: (value) {
                themeProvider.toggleTheme(value);
              },
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'Primární barva',
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Card(
            color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: availableColors.map((color) {
                  final isSelected = themeProvider.primaryColor.toARGB32() == color.toARGB32();
                  return GestureDetector(
                    onTap: () => themeProvider.updatePrimaryColor(color),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: isSelected 
                            ? Border.all(color: theme.colorScheme.onSurface, width: 3)
                            : Border.all(color: Colors.transparent, width: 3),
                        boxShadow: [
                          if (isSelected)
                            BoxShadow(
                              color: color.withValues(alpha: 0.4),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                        ],
                      ),
                      child: isSelected 
                          ? const Icon(Icons.check, color: Colors.white)
                          : null,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
