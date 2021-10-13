import 'package:clean_biblioteca/features/domain/entities/user_progress_entity.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'books_table')
class UserProgressModel extends UserProgressEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  const UserProgressModel({
    this.id,
    required int totalPages,
    required int totalReadPages,
    required double pagesProgress,
    required int books,
    required int completedBooks,
    required double booksProgress,
    required DateTime updatedAt,
  }) : super(
          totalPages: totalPages,
          totalReadPages: totalReadPages,
          pagesProgress: pagesProgress,
          books: books,
          completedBooks: completedBooks,
          booksProgress: booksProgress,
          updatedAt: updatedAt,
        );

  factory UserProgressModel.fromJson(Map<String, dynamic> json) =>
      UserProgressModel(
        totalPages: json['totalPages'],
        totalReadPages: json['totalReadPages'],
        pagesProgress: json['pagesProgress'],
        books: json['books'],
        completedBooks: json['completedBooks'],
        booksProgress: json['booksProgress'],
        updatedAt: json['updatedAt'],
      );

  Map<String, dynamic> toJson() => {
        'totalPages': totalPages,
        'totalReadPages': totalReadPages,
        'progress': pagesProgress,
        'books': books,
        'completedBooks': completedBooks,
        'booksProgress': booksProgress,
        'updatedAt': updatedAt,
      };
}
