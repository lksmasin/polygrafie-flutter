# Polygrafické nástroje (polygrafie-flutter)

Tato aplikace slouží jako pomůcka pro polygrafické práce, jako jsou kalkulace, přehledy formátů papíru a další výpočty. Původně byla napsána v Pythonu, poté přepsána do webových technologií (HTML/CSS/JS) a aktuální verze je postavena na frameworku Flutter.

## Projektový přehled

- **Technologie:** Flutter (Dart)
- **Stav:** Aktivní vývoj, primárním cílem je webová verze (gh-pages).
- **Architektura:**
  - `lib/main.dart`: Hlavní vstupní bod aplikace, nastavení témat a navigace.
  - `lib/theme_provider.dart`: Správa světlého/tmavého režimu a primární barvy aplikace pomocí balíčku `provider`.
  - `lib/pages/`: Obsahuje jednotlivé obrazovky aplikace (Home, Informace, Nastavení).
  - `lib/pages/nastroje/`: Obsahuje specifické polygrafické nástroje:
    - `formaty_pap.dart`: Tabulky rozměrů papíru (ISO A, B, C, SRA, RA).
    - `pocitani_rezu.dart`: Nástroj pro výpočet řezů.
    - `poct_ceny_pap.dart`: Výpočet ceny papíru.
    - `poct_uzit_tisk_arch.dart`: Výpočet užitku na tiskový arch.

## Sestavení a spuštění

Aplikace využívá standardní Flutter příkazy:

- **Instalace závislostí:**
  ```bash
  flutter pub get
  ```

- **Spuštění v debug režimu:**
  ```bash
  flutter run
  ```

- **Sestavení pro web (hlavní cíl):**
  ```bash
  flutter build web
  ```
  Výstup se nachází v `build/web/` a je ručně nahráván do větve `gh-pages`.

- **Statická analýza:**
  ```bash
  flutter analyze
  ```

## Vývojové konvence

- **Lintování:** Projekt používá `flutter_lints` (konfigurace v `analysis_options.yaml`).
- **Správa stavu:** Jednoduchý globální stav (téma) je spravován pomocí `ChangeNotifier` a `Provider`.
- **Lokalizace:** Aplikace je primárně v češtině.
- **Navigace:** Hlavní navigace probíhá přes `NavigationBar` v `RootPage` (lib/main.dart).
- **Téma:** Podpora dynamické změny barev a tmavého režimu, perzistence přes `shared_preferences`.

## Poznámky k testování
- V adresáři `test/` se nachází soubor `test.dart`, který aktuálně slouží spíše jako playground pro testování motivů a barev, nikoliv jako standardní unit nebo widget test.
