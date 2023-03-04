import 'package:biblioteca/core/usecase/errors/failures.dart';
import 'package:biblioteca/modules/books/domain/entities/book_entity.dart';
import 'package:biblioteca/modules/books/domain/entities/book_to_save_entity.dart';
import 'package:biblioteca/modules/books/domain/usecases/create_book_usecase.dart';
import 'package:biblioteca/modules/books/presenter/stores/details_store.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import '../../fakes/fake_path_provider_platform.dart';
import '../../mocks/book_entity_mock.dart';

class MockCreateBooksUsecase extends Mock implements CreateBooksUsecase {}

main() {
  late DetailsStore store;
  late CreateBooksUsecase usecase;

  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() {
    PathProviderPlatform.instance = FakePathProviderPlatform();
    registerFallbackValue(BookToSaveEntity(
        book: BookEntity(
            id: 1,
            name: 'name',
            author: 'author',
            pages: 10,
            readPages: 0,
            stars: 1,
            imagePath: 'image_path'),
        imageFile: null));

    usecase = MockCreateBooksUsecase();
    store = DetailsStore(usecase);
  });

  final tDatabaseFailure = const DatabaseFailure();
  final tImageFailure = const SaveImageFailure();
  final tInfosToSave = BookToSaveEntity(book: tBook, imageFile: XFile('path'));

  test('Should return true from the usecase', () async {
    // Arrange
    when(() => usecase(any())).thenAnswer((_) async => const Right(true));

    // Act
    await store.insertBook(tBook.id, 1, XFile('path'), tBook.imagePath);

    // Assert
    store.observer(onState: (state) {
      expect(state, tBooksList);
      verify(() => usecase(tInfosToSave)).called(1);
    });
  });

  test(
      'Should return a failure from the usecase when there is an error from database',
      () async {
    // Arrange
    when(() => usecase(any())).thenAnswer((_) async => Left(tDatabaseFailure));

    // Act
    await store.insertBook(tBook.id, 1, XFile('path'), tBook.imagePath);

    // Assert
    store.observer(onError: (error) {
      expect(error, tDatabaseFailure);
      verify(() => usecase(tInfosToSave)).called(1);
    });
  });

  test(
      'Should return a failure from the usecase when there is an error from image helper',
      () async {
    // Arrange
    when(() => usecase(any())).thenAnswer((_) async => Left(tImageFailure));

    // Act
    await store.insertBook(tBook.id, 1, XFile('path'), tBook.imagePath);

    // Assert
    store.observer(onError: (error) {
      expect(error, tImageFailure);
      verify(() => usecase(tInfosToSave)).called(1);
    });
  });
}
