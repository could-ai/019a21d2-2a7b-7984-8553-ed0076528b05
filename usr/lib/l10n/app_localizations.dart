import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_localizations.dart';

class AppLocalizations {
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const List<Locale> supportedLocales = [
    Locale('en', ''),
    Locale('bn', ''),
  ];

  // English translations
  static const Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'welcome': 'Welcome',
      'login': 'Login',
      'signup': 'Sign Up',
      'chats': 'Chats',
      'updates': 'Updates',
      'communities': 'Communities',
      'calls': 'Calls',
      'settings': 'Settings',
      'profile': 'Profile',
      'logout': 'Logout',
    },
    'bn': {
      'welcome': 'স্বাগতম',
      'login': 'লগইন',
      'signup': 'নিবন্ধন',
      'chats': 'চ্যাট',
      'updates': 'আপডেট',
      'communities': 'সম্প্রদায়',
      'calls': 'কল',
      'settings': 'সেটিংস',
      'profile': 'প্রোফাইল',
      'logout': 'লগআউট',
    },
  };

  final Locale locale;

  AppLocalizations(this.locale);

  String get welcome => _localizedValues[locale.languageCode]!['welcome']!;
  String get login => _localizedValues[locale.languageCode]!['login']!;
  String get signup => _localizedValues[locale.languageCode]!['signup']!;
  String get chats => _localizedValues[locale.languageCode]!['chats']!;
  String get updates => _localizedValues[locale.languageCode]!['updates']!;
  String get communities => _localizedValues[locale.languageCode]!['communities']!;
  String get calls => _localizedValues[locale.languageCode]!['calls']!;
  String get settings => _localizedValues[locale.languageCode]!['settings']!;
  String get profile => _localizedValues[locale.languageCode]!['profile']!;
  String get logout => _localizedValues[locale.languageCode]!['logout']!;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'bn'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}