import 'package:biblioteca/app/data/repositories/books_repository_implementation.dart';
import 'package:biblioteca/app/utils/image_helper.dart';
import 'package:biblioteca/core/database/datasources/books_datasource.dart';
import 'package:biblioteca/core/database/models/book_model.dart';
import 'package:biblioteca/core/usecase/errors/exceptions.dart';
import 'package:biblioteca/core/usecase/errors/failures.dart';
import 'package:biblioteca/modules/books/domain/entities/book_entity.dart';
import 'package:biblioteca/modules/books/domain/entities/book_to_save_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/book_entity_mock.dart';

class MockBooksDatasource extends Mock implements IBooksDatasource {}

class MockImageHelper extends Mock implements ImageHelper {}

main() {
  late BooksRepositoryImplementation repository;
  late IBooksDatasource datasource;
  late ImageHelper imageHelper;

  setUp(() {
    registerFallbackValue(BookModel(
      name: 'name',
      author: 'author',
      pages: 10,
      readPages: 0,
      stars: 0,
      imagePath: 'imagePath',
      userId: '23',
      updatedAt: DateTime.now(),
    ));
    registerFallbackValue(XFile('path'));

    registerFallbackValue([
      BookEntity(
        id: 1,
        name: 'name',
        author: 'author',
        pages: 10,
        readPages: 0,
        stars: 1,
      ),
    ]);

    datasource = MockBooksDatasource();
    imageHelper = MockImageHelper();
    repository = BooksRepositoryImplementation(datasource, imageHelper);
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
      updatedAt: DateTime.now(),
    ),
  ];

  final tInfosToSave = BookToSaveEntity(book: tBook, imageFile: XFile('path'));

  test('Should return a list of book model when calls the datasource',
      () async {
    // Arrange
    when(() => datasource.getBooks()).thenAnswer((_) async => tBooksList);

    // Act
    final result = await repository.getBooks();

    // Assert
    expect(result, Right(tBooksList));
    verify(() => datasource.getBooks()).called(1);
  });

  test(
      'Should return a database failure when the call to datasource is unsuccessful',
      () async {
    // Arrange
    when(() => datasource.getBooks()).thenThrow(DatabaseException());

    // Act
    final result = await repository.getBooks();

    // Assert
    expect(result, const Left(DatabaseFailure()));
    verify(() => datasource.getBooks()).called(1);
  });

  test('Should return true when calls the datasource to create book', () async {
    // Arrange
    when(() => datasource.createBook(any())).thenAnswer((_) async {});
    when(() => imageHelper.saveImage(any(), any())).thenAnswer((_) async {});

    // Act
    final result = await repository.createBook(tInfosToSave);

    // Assert
    expect(result, const Right(true));
    verify(() => datasource.createBook(tBook.toModel())).called(1);
    verify(() => imageHelper.saveImage(
        tInfosToSave.imageFile!, tInfosToSave.book.imagePath ?? '')).called(1);
  });

  test(
      'Should return a database failure when the call to datasource to create book is unsuccessful',
      () async {
    // Arrange
    when(() => datasource.createBook(any())).thenThrow(DatabaseException());

    // Act
    final result = await repository.createBook(tInfosToSave);

    // Assert
    expect(result, const Left(DatabaseFailure()));
    verify(() => datasource.createBook(tBook.toModel())).called(1);
    verifyNever(() => imageHelper.saveImage(
        tInfosToSave.imageFile!, tInfosToSave.book.imagePath ?? ''));
  });

  test(
      'Should return a database failure when the call to datasource to save image in create book is unsuccessful',
      () async {
    // Arrange
    when(() => datasource.createBook(any())).thenAnswer((_) async {});
    when(() => imageHelper.saveImage(any(), any())).thenThrow(ImageException());

    // Act
    final result = await repository.createBook(tInfosToSave);

    // Assert
    expect(result, const Left(SaveImageFailure()));
    verify(() => datasource.createBook(tBook.toModel())).called(1);
    verify(() => imageHelper.saveImage(
        tInfosToSave.imageFile!, tInfosToSave.book.imagePath ?? '')).called(1);
  });

  test('Should return true when calls delete book from datasource with success',
      () async {
    // Arrange
    when(() => datasource.deleteBook(any())).thenAnswer((_) async {});

    // Act
    final result = await repository.deleteBook(tBook);

    // Assert
    expect(result, const Right(true));
    verify(() => datasource.deleteBook(tBook.toModel())).called(1);
  });

  test(
      'Should return a database failure when the call to datasource is unsuccessful',
      () async {
    // Arrange
    when(() => datasource.deleteBook(any())).thenThrow(DatabaseException());

    // Act
    final result = await repository.deleteBook(tBook);

    // Assert
    expect(result, const Left(DatabaseFailure()));
    verify(() => datasource.deleteBook(tBook.toModel())).called(1);
  });
}
