import 'package:biblioteca/app/domain/errors/failures.dart';
import 'package:biblioteca/app/domain/repositories/books_repository.dart';
import 'package:biblioteca/app/domain/usecases/get_books_usecase.dart';
import 'package:clean_architecture_utils/usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/book_entity_mock.dart';

class MockBooksRepository extends Mock implements IBooksRepository {}

main() {
  late GetBooksUsecase usecase;
  late IBooksRepository repository;

  setUp(() {
    repository = MockBooksRepository();
    usecase = GetBooksUsecase(repository);
  });

  test('Should get books entity list for a give user id from the repository',
      () async {
    // Arrange
    when(() => repository.getBooks())
        .thenAnswer((_) async => Right(tBooksList));

    // Act
    final result = await usecase(NoParams());

    // Assert
    expect(result, Right(tBooksList));
    verify(() => repository.getBooks()).called(1);
  });

  test('Should return a DatabaseFailure when don\'t succeed', () async {
    // Arrange
    when(() => repository.getBooks())
        .thenAnswer((_) async => const Left(DatabaseFailure()));

    // Act
    final result = await usecase(NoParams());

    // Assert
    expect(result, const Left(DatabaseFailure()));
    verify(() => repository.getBooks()).called(1);
  });
}
