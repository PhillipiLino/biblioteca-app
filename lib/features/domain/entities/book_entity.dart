import 'package:equatable/equatable.dart';

class BookEntity extends Equatable {
  final String name;
  final String author;
  final int pages;
  final int readPages;
  final String? imagePath;

  const BookEntity({
    required this.name,
    required this.author,
    required this.pages,
    required this.readPages,
    this.imagePath,
  });

  @override
  List<Object?> get props => [
        name,
        author,
        pages,
        readPages,
        imagePath,
      ];
}
