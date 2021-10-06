import 'package:clean_biblioteca/core/database/book_dao.dart';
import 'package:clean_biblioteca/features/data/datasources/books_datasource.dart';
import 'package:clean_biblioteca/features/data/models/book_model.dart';

class DatabaseDataSourceImplementation implements IBooksDatasource {
  final IBooksDao dao;

  DatabaseDataSourceImplementation(this.dao);

  @override
  Future<List<BookModel>> getBooksFromUser(String userId) {
    return dao.getAllBooksFromUser(userId);
  }
}
