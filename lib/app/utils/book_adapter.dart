import 'package:biblioteca_books_module/biblioteca_books_module.dart';
import 'package:biblioteca_search_module/biblioteca_search_module.dart';

import '../database/models/book_model.dart';

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

extension SearchBookEntityExtension on SearchBookEntity {
  BookEntity toDetails() => BookEntity(
        id: null,
        name: name,
        author: author,
        pages: pages,
        readPages: 0,
        stars: 1,
        imagePath: imagePath,
      );
}
