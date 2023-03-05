import 'package:biblioteca_books_module/biblioteca_books_module.dart';

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
