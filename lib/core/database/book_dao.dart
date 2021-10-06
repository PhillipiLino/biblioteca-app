import 'package:clean_biblioteca/features/data/models/book_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class IBooksDao {
  @Query('Select * from books_table ORDER BY name DESC WHERE user_id = :userId')
  Future<List<BookModel>> getAllBooksFromUser(String userId);
}
