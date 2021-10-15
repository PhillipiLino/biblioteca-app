import 'package:biblioteca/core/database/book_dao.dart';
import 'package:biblioteca/core/usecase/errors/exceptions.dart';
import 'package:biblioteca/modules/books/data/datasources/books_datasource.dart';
import 'package:biblioteca/modules/books/data/models/book_model.dart';

class DatabaseDataSourceImplementation implements IBooksDatasource {
  final IBooksDao dao;

  DatabaseDataSourceImplementation(this.dao);

  @override
  Future<List<BookModel>> getBooks() async {
    try {
      return dao.getBooks();
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<void> createBook(BookModel book) async {
    try {
      return dao.insertBook(book);
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<void> deleteBook(BookModel book) async {
    try {
      return dao.deleteBook(book);
    } catch (e) {
      throw DatabaseException();
    }
  }
}