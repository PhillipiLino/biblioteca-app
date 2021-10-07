import 'package:clean_biblioteca/core/usecase/errors/exceptions.dart';
import 'package:clean_biblioteca/core/usecase/errors/failures.dart';
import 'package:clean_biblioteca/features/data/datasources/books_datasource.dart';
import 'package:clean_biblioteca/features/data/models/book_model.dart';
import 'package:clean_biblioteca/features/data/repositories/books_repository_implementation.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/book_entity_mock.dart';

class MockBooksDatasource extends Mock implements IBooksDatasource {}

main() {
  late BooksRepositoryImplementation repository;
  late IBooksDatasource datasource;

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

    datasource = MockBooksDatasource();
    repository = BooksRepositoryImplementation(datasource);
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

  test('Should return a list of book model when calls the datasource',
      () async {
    // Arrange
    when(() => datasource.getBooksFromUser(any()))
        .thenAnswer((_) async => tBooksList);

    // Act
    final result = await repository.getUserBooks(tUserId);

    // Assert
    expect(result, Right(tBooksList));
    verify(() => datasource.getBooksFromUser(tUserId)).called(1);
  });

  test(
      'Should return a database failure when the call to datasource is unsuccessful',
      () async {
    // Arrange
    when(() => datasource.getBooksFromUser(any()))
        .thenThrow(DatabaseException());

    // Act
    final result = await repository.getUserBooks(tUserId);

    // Assert
    expect(result, Left(DatabaseFailure()));
    verify(() => datasource.getBooksFromUser(tUserId)).called(1);
  });

  test('Should return true when calls the datasource to create book', () async {
    // Arrange
    when(() => datasource.createBook(any())).thenAnswer((_) async {});

    // Act
    final result = await repository.createBook(tBook);

    // Assert
    expect(result, const Right(true));
    verify(() => datasource.createBook(tBook.toModel())).called(1);
  });

  test(
      'Should return a database failure when the call to datasource to crreate book is unsuccessful',
      () async {
    // Arrange
    when(() => datasource.createBook(any())).thenThrow(DatabaseException());

    // Act
    final result = await repository.createBook(tBook);

    // Assert
    expect(result, Left(DatabaseFailure()));
    verify(() => datasource.createBook(tBook.toModel())).called(1);
  });
}
