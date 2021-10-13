import 'package:biblioteca/core/usecase/errors/failures.dart';
import 'package:biblioteca/features/domain/usecases/get_user_books_usecase.dart';
import 'package:biblioteca/features/presenter/controller/home_store.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/book_entity_mock.dart';

class MockGetUserBooksUsecase extends Mock implements GetUserBooksUsecase {}

main() {
  late HomeStore store;
  late GetUserBooksUsecase usecase;

  setUp(() {
    usecase = MockGetUserBooksUsecase();
    store = HomeStore(usecase);
  });

  const tUserId = '23';
  final tFailure = DatabaseFailure();

  test('Should return a list of BookEntity from the usecase', () async {
    // Arrange
    when(() => usecase(any())).thenAnswer((_) async => Right(tBooksList));

    // Act
    await store.getBooksFromUser(tUserId);

    // Assert
    store.observer(onState: (state) {
      expect(state, tBooksList);
      verify(() => usecase(tUserId)).called(1);
    });
  });

  test('Should return a failure from the usecase when there is an error',
      () async {
    // Arrange
    when(() => usecase(any())).thenAnswer((_) async => Left(tFailure));

    // Act
    await store.getBooksFromUser(tUserId);

    // Assert
    store.observer(onError: (error) {
      expect(error, tFailure);
      verify(() => usecase(tUserId)).called(1);
    });
  });
}
