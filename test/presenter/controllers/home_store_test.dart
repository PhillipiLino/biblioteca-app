import 'package:biblioteca/core/usecase/errors/failures.dart';
import 'package:biblioteca/core/utils/routes/app_routes.dart';
import 'package:biblioteca/modules/books/domain/usecases/get_books_usecase.dart';
import 'package:biblioteca/modules/books/presenter/stores/home_store.dart';
import 'package:biblioteca/modules/books/presenter/utils/persist_list_helper.dart';
import 'package:clean_architecture_utils/usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/book_entity_mock.dart';

class MockGetUserBooksUsecase extends Mock implements GetBooksUsecase {}

main() {
  late HomeStore store;
  late GetBooksUsecase usecase;

  setUp(() {
    registerFallbackValue(NoParams());
    usecase = MockGetUserBooksUsecase();
    store = HomeStore(usecase, PersistListHelper(), AppRoutes(), null);
  });

  const tFailure = DatabaseFailure();

  test('Should return a list of BookEntity from the usecase', () async {
    // Arrange
    when(() => usecase(any())).thenAnswer((_) async => Right(tBooksList));

    // Act
    await store.getBooks();

    // Assert
    store.observer(onState: (state) {
      expect(state, tBooksList);
      verify(() => usecase(NoParams())).called(1);
    });
  });

  test('Should return a failure from the usecase when there is an error',
      () async {
    // Arrange
    when(() => usecase(any())).thenAnswer((_) async => const Left(tFailure));

    // Act
    await store.getBooks();

    // Assert
    store.observer(onError: (error) {
      expect(error, tFailure);
      verify(() => usecase(NoParams())).called(1);
    });
  });
}
