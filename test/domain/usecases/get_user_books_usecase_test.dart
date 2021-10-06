import 'package:clean_biblioteca/core/usecase/errors/failures.dart';
import 'package:clean_biblioteca/features/domain/entities/book_entity.dart';
import 'package:clean_biblioteca/features/domain/repositories/books_repository.dart';
import 'package:clean_biblioteca/features/domain/usecases/get_user_books_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBooksRepository extends Mock implements IBooksRepository {}

main() {
  late GetUserBooksUsecase usecase;
  late IBooksRepository repository;

  setUp(() {
    repository = MockBooksRepository();
    usecase = GetUserBooksUsecase(repository);
  });

  const tUserId = '21';

  const tBooksList = [
    BookEntity(name: 'name', author: 'author', pages: 12, readPages: 8)
  ];

  test('Should get books entity list for a give user id from the repository',
      () async {
    // Arrange
    when(() => repository.getUserBooks(any()))
        .thenAnswer((_) async => const Right(tBooksList));

    // Act
    final result = await usecase(tUserId);

    // Assert
    expect(result, const Right(tBooksList));
    verify(() => repository.getUserBooks(tUserId)).called(1);
  });

  test('Should return a DatabaseFailure when don\'t succeed', () async {
    // Arrange
    when(() => repository.getUserBooks(any()))
        .thenAnswer((_) async => Left(DatabaseFailure()));

    // Act
    final result = await usecase(tUserId);

    // Assert
    expect(result, Left(DatabaseFailure()));
    verify(() => repository.getUserBooks(tUserId)).called(1);
  });
}
