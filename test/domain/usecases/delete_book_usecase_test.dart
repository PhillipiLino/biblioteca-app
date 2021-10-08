import 'package:clean_biblioteca/core/usecase/errors/failures.dart';
import 'package:clean_biblioteca/features/domain/entities/book_entity.dart';
import 'package:clean_biblioteca/features/domain/repositories/books_repository.dart';
import 'package:clean_biblioteca/features/domain/usecases/delete_book_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/book_entity_mock.dart';

class MockBooksRepository extends Mock implements IBooksRepository {}

main() {
  late DeleteBookUsecase usecase;
  late IBooksRepository repository;

  setUp(() {
    registerFallbackValue(BookEntity(
      id: 1,
      name: 'name',
      author: 'author',
      pages: 10,
      readPages: 0,
      stars: 1,
    ));

    repository = MockBooksRepository();
    usecase = DeleteBookUsecase(repository);
  });

  test('Should get books entity list for a give user id from the repository',
      () async {
    // Arrange
    when(() => repository.deleteBook(any()))
        .thenAnswer((_) async => const Right(true));

    // Act
    final result = await usecase(tBook);

    // Assert
    expect(result, const Right(true));
    verify(() => repository.deleteBook(tBook)).called(1);
  });

  test('Should return a DatabaseFailure when don\'t succeed', () async {
    // Arrange
    when(() => repository.deleteBook(any()))
        .thenAnswer((_) async => Left(DatabaseFailure()));

    // Act
    final result = await usecase(tBook);

    // Assert
    expect(result, Left(DatabaseFailure()));
    verify(() => repository.deleteBook(tBook)).called(1);
  });
}
