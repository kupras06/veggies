import 'dart:ui';

abstract class Languages {
  static const List<String> supportedLanguages = ['en', 'es', 'fr'];
  static const List<Locale> supportedLocales = [
    Locale('en', 'US'),
    Locale('es', 'ES'),
    Locale('fr', 'FR'),
  ];
}
