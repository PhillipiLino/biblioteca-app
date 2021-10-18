import 'package:biblioteca/core/usecase/errors/failures.dart';
import 'package:biblioteca/features/domain/entities/book_entity.dart';
import 'package:biblioteca/features/domain/entities/book_to_save_entity.dart';
import 'package:biblioteca/features/domain/repositories/books_repository.dart';
import 'package:biblioteca/features/domain/usecases/create_book_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/book_entity_mock.dart';

class MockBooksRepository extends Mock implements IBooksRepository {}

main() {
  late CreateBooksUsecase usecase;
  late IBooksRepository repository;

  setUp(() {
    registerFallbackValue(BookToSaveEntity(
        book: BookEntity(
          id: 1,
          name: 'name',
          author: 'author',
          pages: 10,
          readPages: 0,
          stars: 1,
        ),
        imageFile: null));

    repository = MockBooksRepository();
    usecase = CreateBooksUsecase(repository);
  });

  final tInfosToSave = BookToSaveEntity(book: tBook, imageFile: XFile('path'));

  test('Should return true for a create book on repository with success',
      () async {
    // Arrange
    when(() => repository.createBook(any()))
        .thenAnswer((_) async => const Right(true));

    // Act
    final result = await usecase(tInfosToSave);

    // Assert
    expect(result, const Right(true));
    verify(() => repository.createBook(tInfosToSave)).called(1);
  });

  test('Should return a DatabaseFailure when don\'t succeed', () async {
    // Arrange
    when(() => repository.createBook(any()))
        .thenAnswer((_) async => Left(DatabaseFailure()));

    // Act
    final result = await usecase(tInfosToSave);

    // Assert
    expect(result, Left(DatabaseFailure()));
    verify(() => repository.createBook(tInfosToSave)).called(1);
  });
}
