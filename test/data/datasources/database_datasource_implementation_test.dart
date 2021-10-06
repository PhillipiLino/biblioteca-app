import 'package:clean_biblioteca/core/database/book_dao.dart';
import 'package:clean_biblioteca/features/data/datasources/database_datasource_implementation.dart';
import 'package:clean_biblioteca/features/data/models/book_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBooksDao extends Mock implements IBooksDao {}

main() {
  late DatabaseDataSourceImplementation datasource;
  late IBooksDao dao;

  setUp(() {
    dao = MockBooksDao();
    datasource = DatabaseDataSourceImplementation(dao);
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

  test('Should return a list of BookModel when is successfull', () async {
    // Arrange
    when(() => dao.getAllBooksFromUser(any()))
        .thenAnswer((_) async => tBooksList);

    // Act
    final result = await datasource.getBooksFromUser(tUserId);

    // Assert
    expect(result, tBooksList);
    verify(() => dao.getAllBooksFromUser(tUserId)).called(1);
  });
}
