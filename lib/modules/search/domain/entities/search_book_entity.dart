import 'package:biblioteca_books_module/biblioteca_books_module.dart';
import 'package:biblioteca_sdk/models.dart';
import 'package:equatable/equatable.dart';

class SearchBookEntity extends Equatable {
  final String? id;
  final String name;
  final String author;
  final int pages;
  final String? imagePath;

  static const unknownAuthor = 'Desconhecido';

  const SearchBookEntity({
    required this.id,
    required this.name,
    required this.author,
    required this.pages,
    this.imagePath,
  });

  SearchBookEntity.fromGoogleModel(GoogleBookModel model)
      : id = model.id,
        name = model.title ?? '',
        pages = model.pageCount ?? 0,
        imagePath = model.imagePath,
        author = (model.authors ?? []).isEmpty
            ? unknownAuthor
            : model.authors?.first ?? unknownAuthor;

  toDetails() {
    return BookEntity(
      id: null,
      name: name,
      author: author,
      pages: pages,
      readPages: 0,
      stars: 1,
      imagePath: imagePath,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        author,
        pages,
        imagePath,
      ];
}
