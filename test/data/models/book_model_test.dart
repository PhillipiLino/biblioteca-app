import 'dart:convert';

import 'package:biblioteca/app/database/models/book_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks/book_mock.dart';

main() {
  final tBookModel = BookModel(
    databaseId: 1,
    name: 'name',
    author: 'author',
    pages: 10,
    readPages: 8,
    stars: 3,
    imagePath: 'imagePath',
    userId: '23',
    updatedAt: DateTime(2021, 10, 13),
  );

  test('Should return a valid model', () {
    // Arrange
    final Map<String, dynamic> jsonMap = jsonDecode(bookMock);

    // Act
    final result = BookModel.fromJson(jsonMap);

    // Assert
    expect(result, tBookModel);
  });

  test('Should return a json map containing the proper data', () {
    // Arrange
    final expectedJson = jsonDecode(bookMock);

    // Act
    final result = tBookModel.toJson();

    // Assert
    expect(result, expectedJson);
  });
}
