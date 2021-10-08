import 'package:clean_biblioteca/core/database/book_dao.dart';
import 'package:clean_biblioteca/core/usecase/errors/exceptions.dart';
import 'package:clean_biblioteca/features/data/datasources/database_datasource_implementation.dart';
import 'package:clean_biblioteca/features/data/models/book_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/book_entity_mock.dart';

class MockBooksDao extends Mock implements IBooksDao {}

main() {
  late DatabaseDataSourceImplementation datasource;
  late IBooksDao dao;

  setUp(() {
    registerFallbackValue(BookModel(
      name: 'name',
      author: 'author',
      pages: 10,
      readPages: 0,
      stars: 0,
      imagePath: 'imagePath',
      userId: '23',
    ));

    dao = MockBooksDao();
    datasource = DatabaseDataSourceImplementation(dao);
  });

  final tBooksList = [
    BookModel(
      name: 'name',
      author: 'author',
      pages: 10,
      readPages: 8,
      stars: 3,
      imagePath: 'imagePath',
      userId: '23',
    ),
  ];

  const tUserId = '23';

  test('Should return a list of BookModel when is successfull', () async {
    // Arrange
    when(() => dao.getAllBooksFromUser(any()))
        .thenAnswer((_) async => tBooksList);

    // Act
    final result = await datasource.getBooksFromUser(tUserId);

    // Assert
    expect(result, tBooksList);
    verify(() => dao.getAllBooksFromUser(tUserId)).called(1);
  });

  test('Should throw a DatabaseException when get all books call is unccessful',
      () async {
    // Arrange
    when(() => dao.getAllBooksFromUser(any())).thenThrow(Exception());

    // Act
    final result = datasource.getBooksFromUser(tUserId);

    // Assert
    expect(() => result, throwsA(DatabaseException()));
  });

  test('Should complete flow when insert book with successfull', () async {
    // Arrange
    when(() => dao.insertBook(any())).thenAnswer((_) async {});

    // Act
    final result = datasource.createBook(tBook.toModel());

    // Assert
    expect(result, completes);
    verify(() => dao.insertBook(tBook.toModel())).called(1);
  });

  test('Should throw a DatabaseException when insert book call is unccessful',
      () {
    // Arrange
    when(() => dao.insertBook(any())).thenThrow(Exception());

    // Act
    final result = datasource.createBook(tBook.toModel());

    // Assert
    expect(() => result, throwsA(DatabaseException()));
  });

  test('Should complete flow when delete book with successfull', () async {
    // Arrange
    when(() => dao.deleteBook(any())).thenAnswer((_) async {});

    // Act
    final result = datasource.deleteBook(tBook.toModel());

    // Assert
    expect(result, completes);
    verify(() => dao.deleteBook(tBook.toModel())).called(1);
  });

  test('Should throw a DatabaseException when delete book call is unccessful',
      () {
    // Arrange
    when(() => dao.deleteBook(any())).thenThrow(Exception());

    // Act
    final result = datasource.deleteBook(tBook.toModel());

    // Assert
    expect(() => result, throwsA(DatabaseException()));
  });
}
