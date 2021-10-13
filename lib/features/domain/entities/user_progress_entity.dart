import 'package:equatable/equatable.dart';

class UserProgressEntity extends Equatable {
  final int totalPages;
  final int totalReadPages;
  final double pagesProgress;

  final int books;
  final int completedBooks;
  final double booksProgress;
  final DateTime updatedAt;

  const UserProgressEntity({
    required this.totalPages,
    required this.totalReadPages,
    required this.pagesProgress,
    required this.books,
    required this.completedBooks,
    required this.booksProgress,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        totalPages,
        totalReadPages,
        pagesProgress,
        books,
        completedBooks,
        booksProgress,
        updatedAt,
      ];
}
