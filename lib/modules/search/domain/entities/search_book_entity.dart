import 'package:equatable/equatable.dart';

class SearchBookEntity extends Equatable {
  final String? id;
  final String name;
  final String author;
  final int pages;
  final String? imagePath;

  const SearchBookEntity({
    required this.id,
    required this.name,
    required this.author,
    required this.pages,
    this.imagePath,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        author,
        pages,
        imagePath,
      ];
}
