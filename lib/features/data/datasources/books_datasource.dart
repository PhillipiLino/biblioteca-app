import 'package:biblioteca/features/data/models/book_model.dart';
import 'package:biblioteca/features/data/models/user_progress_model.dart';

abstract class IBooksDatasource {
  Future<List<BookModel>> getBooksFromUser(String userId);
  Future<void> createBook(BookModel book);
  Future<void> deleteBook(BookModel book);
  Future<List<UserProgressModel>?> getProgress();
}
