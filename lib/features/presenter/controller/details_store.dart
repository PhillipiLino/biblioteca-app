import 'package:clean_biblioteca/core/usecase/errors/failures.dart';
import 'package:clean_biblioteca/core/utils/adapters/dartz_either_adapter.dart';
import 'package:clean_biblioteca/features/domain/entities/book_entity.dart';
import 'package:clean_biblioteca/features/domain/entities/book_to_save_entity.dart';
import 'package:clean_biblioteca/features/domain/usecases/create_book_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';

class DetailsStore extends NotifierStore<Failure, bool> {
  final CreateBooksUsecase usecase;

  late final TextEditingController nameController;
  late final TextEditingController authorController;
  late final TextEditingController pagesController;
  late final TextEditingController readPagesController;

  DetailsStore(this.usecase) : super(true);

  initTextControllers(BookEntity? initialBook) {
    final name = initialBook?.name ?? '';
    final author = initialBook?.author ?? '';
    final pages = initialBook?.pages ?? 0;
    final readPages = initialBook?.readPages ?? 0;

    nameController = TextEditingController(text: name);
    authorController = TextEditingController(text: author);
    pagesController = TextEditingController(text: pages.toString());
    readPagesController = TextEditingController(text: readPages.toString());
  }

  insertBook(BookToSaveEntity book) async {
    executeEither(() => DartzEitherAdapter.adapter(usecase(book)));
  }
}
