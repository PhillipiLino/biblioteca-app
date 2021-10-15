import 'package:biblioteca/modules/books/domain/entities/book_entity.dart';
import 'package:biblioteca/modules/search/domain/entities/search_book_entity.dart';

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
