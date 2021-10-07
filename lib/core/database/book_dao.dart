import 'package:clean_biblioteca/features/data/models/book_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class IBooksDao {
  @Query(
      'Select * from books_table WHERE user_id = :userId ORDER BY name DESC ')
  Future<List<BookModel>> getAllBooksFromUser(String userId);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertBook(BookModel book);
}
