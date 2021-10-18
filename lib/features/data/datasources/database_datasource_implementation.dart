import 'package:biblioteca/core/database/book_dao.dart';
import 'package:biblioteca/core/usecase/errors/exceptions.dart';
import 'package:biblioteca/features/data/datasources/books_datasource.dart';
import 'package:biblioteca/features/data/models/book_model.dart';
import 'package:biblioteca/features/data/models/user_progress_model.dart';

class DatabaseDataSourceImplementation implements IBooksDatasource {
  final IBooksDao dao;

  DatabaseDataSourceImplementation(this.dao);

  @override
  Future<List<BookModel>> getBooksFromUser(String userId) async {
    try {
      return dao.getAllBooksFromUser(userId);
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

  @override
  Future<List<UserProgressModel>?> getProgress() async {
    try {
      return dao.getProgress();
    } catch (e) {
      throw DatabaseException();
    }
  }
}
