import 'package:biblioteca/modules/books/data/models/book_model.dart';

abstract class IBooksDatasource {
  Future<List<BookModel>> getBooks();
  Future<void> createBook(BookModel book);
  Future<void> deleteBook(BookModel book);
}
