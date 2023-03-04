// coverage:ignore-file

import 'package:clean_architecture_utils/localizations.dart';
import 'package:flutter/material.dart';

import 'menu_localization.dart';
import 'messages/messages_all.dart';

class MenuModuleLocalizationsDelegate
    extends LocalizationsDelegate<MenuModuleLocalizations> {
  const MenuModuleLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['pt', 'en'].contains(locale.languageCode);

  @override
  Future<MenuModuleLocalizations> load(Locale locale) =>
      MultipleLocalizations.load(initializeMessages, locale,
          (l) => MenuModuleLocalizations.load(locale),
          setDefaultLocale: true);

  @override
  bool shouldReload(LocalizationsDelegate<MenuModuleLocalizations> old) =>
      false;
}
