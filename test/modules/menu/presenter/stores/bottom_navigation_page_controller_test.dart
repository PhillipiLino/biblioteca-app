import 'package:biblioteca/core/utils/routes/app_routes.dart';
import 'package:biblioteca/modules/menu/presenter/stores/bottom_navigation_page_store.dart';
import 'package:biblioteca/modules/menu/presenter/utils/bottom_navigation_item.dart';
import 'package:biblioteca/modules/menu/presenter/utils/bottom_navigation_page_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../testDoubles/mocks/app_router_mock.dart';

main() {
  late AppRoutes routes;

  late BottomNavigationPageStore controller;

  setUp(() {
    routes = AppRoutesMock();

    controller = BottomNavigationPageStore(routes, null);
  });

  setUpAll(() {
    registerFallbackValue(BottomNavigationItem.books);
  });

  testWidgets('Set current page books', (tester) async {
    // Given
    const data = BottomNavigationPageData(
      BottomNavigationItem.books,
      null,
    );

    // When
    controller.setRoute(data);

    // Then
    expect(controller.state, 0);
  });

  testWidgets('Set current page search', (tester) async {
    // Given
    const data = BottomNavigationPageData(
      BottomNavigationItem.search,
      null,
    );

    // When
    controller.setRoute(data);

    // Then
    expect(controller.state, 1);
  });

  testWidgets('Set current page profile', (tester) async {
    // Given
    const data = BottomNavigationPageData(
      BottomNavigationItem.profile,
      null,
    );

    // When
    controller.setRoute(data);

    // Then
    expect(controller.state, 2);
  });

  test('Go to same page', () {
    // Given
    const pageIndex = 0;

    // When
    // ignore: invalid_use_of_protected_member
    controller.update(0);
    controller.goToPage(pageIndex, null);

    // Then
    verifyNever(() => routes.goToMenu(any(), any()));
  });

  test('Go to page 0', () {
    // Given
    const pageIndex = 0;

    // When
    controller.goToPage(1, null);
    controller.goToPage(pageIndex, null);

    // Then
    verify(() => routes.goToMenu(BottomNavigationItem.books, null)).called(1);
  });

  test('Go to page 1', () {
    // Given
    const pageIndex = 1;

    // When
    controller.goToPage(pageIndex, null);

    // Then
    verify(() => routes.goToMenu(BottomNavigationItem.search, null)).called(1);
  });

  test('Go to page 2', () {
    // Given
    const pageIndex = 2;

    // When
    controller.goToPage(pageIndex, null);

    // Then
    verify(() => routes.goToMenu(BottomNavigationItem.profile, null)).called(1);
  });
}
