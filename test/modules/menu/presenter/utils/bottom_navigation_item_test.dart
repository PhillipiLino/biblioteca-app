import 'package:biblioteca/app/utils/routes/constants.dart';
import 'package:biblioteca/modules/menu/localizations/menu_localization.dart';
import 'package:biblioteca/modules/menu/localizations/menu_localizations_delegate.dart';
import 'package:biblioteca/modules/menu/presenter/utils/bottom_navigation_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  const locale = Locale('pt_Br');

  setUpAll(() {
    const MenuModuleLocalizationsDelegate().load(locale);
  });

  test('Check item books', () async {
    // Arrange
    const item = BottomNavigationItem.books;

    // Assert
    final localization =
        (await MenuModuleLocalizations.load(locale)).bottomNavigation;
    expect(item.route, booksRoute);
    expect(item.icon, Icons.menu_book);
    expect(item.title, localization.booksTab);
  });
  test('Check item search', () async {
    // Arrange
    const item = BottomNavigationItem.search;

    // Assert
    final localization =
        (await MenuModuleLocalizations.load(locale)).bottomNavigation;
    expect(item.route, searchRoute);
    expect(item.icon, Icons.search);
    expect(item.title, localization.searchTab);
  });
  test('Check item profile', () async {
    // Arrange
    const item = BottomNavigationItem.profile;

    // Assert
    final localization =
        (await MenuModuleLocalizations.load(locale)).bottomNavigation;
    expect(item.route, profileRoute);
    expect(item.icon, Icons.person);
    expect(item.title, localization.profileTab);
  });
}
