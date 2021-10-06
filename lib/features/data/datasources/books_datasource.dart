import 'package:clean_biblioteca/features/data/models/book_model.dart';

abstract class IBooksDatasource {
  Future<List<BookModel>> getBooksFromUser(String userId);
}
