import '../../domain/errors/exceptions.dart';
import '../book_dao.dart';
import '../models/book_model.dart';
import 'books_datasource.dart';

class BooksDataSourceImplementation implements IBooksDatasource {
  final IBooksDao dao;

  BooksDataSourceImplementation(this.dao);

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
