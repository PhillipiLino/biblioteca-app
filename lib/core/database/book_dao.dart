import 'package:biblioteca/features/data/models/book_model.dart';
import 'package:biblioteca/modules/profile/data/models/user_progress_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class IBooksDao {
  @Query(
      'Select * from books_table WHERE user_id = :userId ORDER BY updated_at DESC')
  Future<List<BookModel>> getAllBooksFromUser(String userId);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertBook(BookModel book);

  @delete
  Future<void> deleteBook(BookModel book);

  @Query('''Select SUM(pages) as totalPages, 
      Sum(readPages) as totalReadPages, 
      ((Sum(readPages) * 100.0)/Sum(pages)) as pagesProgress,
      Count(*) as books,
      Count(case when pages = readPages Then 1 else NULL end) as completedBooks,
      ((Count(case when pages = readPages Then 1 else NULL end) * 100.0)/Count(*)) as booksProgress,
      max(updated_at) updatedAt from books_table''')
  Future<List<UserProgressModel>?> getProgress();
}
