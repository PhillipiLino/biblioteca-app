import 'package:clean_biblioteca/core/usecase/errors/failures.dart';
import 'package:clean_biblioteca/features/domain/entities/book_entity.dart';
import 'package:clean_biblioteca/features/domain/usecases/delete_book_usecase.dart';
import 'package:clean_biblioteca/features/presenter/widgets/books_list/books_list_store.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import '../../fakes/fake_path_provider_platform.dart';
import '../../mocks/book_entity_mock.dart';

class MockDeleteBookUsecase extends Mock implements DeleteBookUsecase {}

main() {
  late BooksListStore store;
  late DeleteBookUsecase usecase;

  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() {
    PathProviderPlatform.instance = FakePathProviderPlatform();
    registerFallbackValue(BookEntity(
        id: 1,
        name: 'name',
        author: 'author',
        pages: 10,
        readPages: 0,
        stars: 1,
        imagePath: 'image_path'));

    usecase = MockDeleteBookUsecase();
    store = BooksListStore(usecase);
  });

  final tDatabaseFailure = DatabaseFailure();
  final tImageFailure = SaveImageFailure();

  test('Should return true from the usecase', () async {
    // Arrange
    when(() => usecase(any())).thenAnswer((_) async => const Right(true));

    // Act
    await store.deleteBook(tBook);

    // Assert
    store.observer(onState: (state) {
      expect(state, true);
      verify(() => usecase(tBook)).called(1);
    });
  });

  test(
      'Should return a failure from the usecase when there is an error from database',
      () async {
    // Arrange
    when(() => usecase(any())).thenAnswer((_) async => Left(tDatabaseFailure));

    // Act
    await store.deleteBook(tBook);

    // Assert
    store.observer(onError: (error) {
      expect(error, tDatabaseFailure);
      verify(() => usecase(tBook)).called(1);
    });
  });

  test(
      'Should return a failure from the usecase when there is an error from image helper',
      () async {
    // Arrange
    when(() => usecase(any())).thenAnswer((_) async => Left(tImageFailure));

    // Act
    await store.deleteBook(tBook);

    // Assert
    store.observer(onError: (error) {
      expect(error, tImageFailure);
      verify(() => usecase(tBook)).called(1);
    });
  });
}
