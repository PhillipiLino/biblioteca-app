// coverage:ignore-file

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'messages/messages_all.dart';

class MenuModuleLocalizations {
  static Future<MenuModuleLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return MenuModuleLocalizations();
    });
  }

  static MenuModuleLocalizations? of(BuildContext context) {
    return Localizations.of<MenuModuleLocalizations>(
        context, MenuModuleLocalizations);
  }

  final bottomNavigation = _BottomNavigation();
}

class _BottomNavigation {
  String get booksTab => Intl.message('', name: 'booksTab');
  String get searchTab => Intl.message('', name: 'searchTab');
  String get profileTab => Intl.message('', name: 'profileTab');
}
