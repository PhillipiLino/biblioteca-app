import 'package:floor/floor.dart';

import 'models/book_model.dart';
import 'models/user_progress_model.dart';

@dao
abstract class IBooksDao {
  @Query('Select * from books_table ORDER BY updated_at DESC')
  Future<List<BookModel>> getBooks();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertBook(BookModel book);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertBooks(List<BookModel> books);

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
