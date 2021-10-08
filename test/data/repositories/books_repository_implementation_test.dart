import 'package:clean_biblioteca/core/usecase/errors/exceptions.dart';
import 'package:clean_biblioteca/core/usecase/errors/failures.dart';
import 'package:clean_biblioteca/core/utils/helpers/image_helper.dart';
import 'package:clean_biblioteca/features/data/datasources/books_datasource.dart';
import 'package:clean_biblioteca/features/data/models/book_model.dart';
import 'package:clean_biblioteca/features/data/repositories/books_repository_implementation.dart';
import 'package:clean_biblioteca/features/domain/entities/book_entity.dart';
import 'package:clean_biblioteca/features/domain/entities/book_to_save_entity.dart';
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
    ),
  ];

  const tUserId = '23';
  final tInfosToSave = BookToSaveEntity(book: tBook, imageFile: XFile('path'));

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
    expect(result, Left(DatabaseFailure()));
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
    expect(result, Left(SaveImageFailure()));
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
    expect(result, Left(DatabaseFailure()));
    verify(() => datasource.deleteBook(tBook.toModel())).called(1);
  });
}
