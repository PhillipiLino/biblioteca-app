import 'package:biblioteca/modules/menu/presenter/utils/bottom_navigation_item.dart';
import 'package:biblioteca/modules/menu/presenter/utils/bottom_navigation_page_data.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  const tItem = BottomNavigationItem.books;
  const tData = 5000.0;

  test('Create BottomNavigationPageData', () {
    // Act
    const params = BottomNavigationPageData(tItem, tData);

    // Assert
    expect(params.navigationItem, tItem);
    expect(params.childData, tData);
  });

  test('Test equals', () {
    // Arrange
    const entityOne = BottomNavigationPageData(tItem, tData);

    const entityTwo = BottomNavigationPageData(tItem, tData);

    // Assert
    expect(entityOne == entityTwo, isTrue);
  });

  test('Test not equals', () {
    // Arrange
    const entityOne = BottomNavigationPageData(tItem, false);

    const entityTwo = BottomNavigationPageData(tItem, tData);

    // Assert
    expect(entityOne == entityTwo, isFalse);
  });
}
