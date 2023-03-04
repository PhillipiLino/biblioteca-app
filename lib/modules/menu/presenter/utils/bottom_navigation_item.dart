import 'package:flutter/material.dart';

import '../../../../core/utils/routes/constants.dart';
import '../../localizations/menu_localization.dart';

enum BottomNavigationItem {
  books(booksRoute, Icons.menu_book),
  search(searchRoute, Icons.search),
  profile(profileRoute, Icons.person);

  const BottomNavigationItem(this.route, this.icon);
  final String route;
  final IconData icon;
}

extension BottomNavigationItemExtension on BottomNavigationItem {
  static final _localizations = MenuModuleLocalizations().bottomNavigation;
  String get title {
    switch (this) {
      case BottomNavigationItem.books:
        return _localizations.booksTab;
      case BottomNavigationItem.search:
        return _localizations.searchTab;
      case BottomNavigationItem.profile:
        return _localizations.profileTab;
    }
  }
}
