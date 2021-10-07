import 'package:clean_biblioteca/core/usecase/errors/failures.dart';
import 'package:clean_biblioteca/core/utils/adapters/dartz_either_adapter.dart';
import 'package:clean_biblioteca/features/domain/entities/book_entity.dart';
import 'package:clean_biblioteca/features/domain/entities/book_to_save_entity.dart';
import 'package:clean_biblioteca/features/domain/usecases/create_book_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class DetailsStore extends NotifierStore<Failure, bool> {
  final CreateBooksUsecase usecase;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController pagesController = TextEditingController();
  final TextEditingController readPagesController = TextEditingController();

  DetailsStore(this.usecase) : super(true);

  initTextControllers(BookEntity? initialBook) {
    final name = initialBook?.name ?? '';
    final author = initialBook?.author ?? '';
    final pages = initialBook?.pages ?? 0;
    final readPages = initialBook?.readPages ?? 0;

    nameController.text = name;
    authorController.text = author;
    pagesController.text = pages.toString();
    readPagesController.text = readPages.toString();
  }

  insertBook(int? bookId, int stars, XFile? imageFile) async {
    final name = nameController.text;
    final author = authorController.text;
    final pages = int.tryParse(pagesController.text) ?? 0;
    final readPages = int.tryParse(readPagesController.text) ?? 0;

    final date =
        DateTime.now().toString().replaceAll(':', '_').replaceAll(' ', '_');
    final imageName = 'book_${name.hashCode}_$date';
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/$imageName';

    final book = BookToSaveEntity(
      book: BookEntity(
        id: bookId,
        name: name,
        author: author,
        pages: pages,
        readPages: readPages,
        stars: stars,
        imagePath: path,
      ),
      imageFile: imageFile,
    );

    executeEither(() => DartzEitherAdapter.adapter(usecase(book)));
  }
}
