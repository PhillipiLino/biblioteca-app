import '../models/book_model.dart';

abstract class IBooksDatasource {
  Future<List<BookModel>> getBooks();
  Future<void> updateBooks(List<BookModel> books);
  Future<void> createBook(BookModel book);
  Future<void> deleteBook(BookModel book);
}
