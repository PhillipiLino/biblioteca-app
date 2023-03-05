import 'package:biblioteca/modules/books/data/models/book_model.dart';
import 'package:biblioteca/modules/search/domain/entities/search_book_entity.dart';
import 'package:biblioteca_books_module/biblioteca_books_module.dart';

extension SearchBookEntityExtension on SearchBookEntity {
  BookEntity toDetails() {
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
}

extension BookEntityExtension on BookEntity {
  BookModel toModel() => BookModel(
        databaseId: id,
        name: name,
        author: author,
        pages: pages,
        readPages: readPages,
        stars: stars,
        imagePath: imagePath,
        userId: '0',
        updatedAt: DateTime.now(),
      );
}
