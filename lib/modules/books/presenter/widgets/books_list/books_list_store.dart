import 'package:biblioteca/core/usecase/errors/failures.dart';
import 'package:biblioteca/core/utils/adapters/dartz_either_adapter.dart';
import 'package:biblioteca/modules/books/domain/entities/book_entity.dart';
import 'package:biblioteca/modules/books/domain/usecases/delete_book_usecase.dart';
import 'package:commons_tools_sdk/commons_tools_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

class BooksListStore extends NotifierStore<Failure, bool> {
  final DeleteBookUsecase usecase;
  final _debouncer = Debouncer(milliseconds: 800);
  final pageController = PageController(viewportFraction: 0.65, initialPage: 0);
  final scrollController = ScrollController();

  BooksListStore(this.usecase) : super(true);

  deleteBook(BookEntity book) async {
    executeEither(() => DartzEitherAdapter.adapter(usecase(book)));
  }

  closeDialog(bool confirm) => Modular.to.pop(confirm);

  searchBookInList(String text, List<BookEntity> list, int currentPage) {
    if (text.isEmpty) return;
    _debouncer.run(() {
      final term = text.toLowerCase().removeDiacritics();
      final index = list.indexWhere((element) =>
          element.name.toLowerCase().removeDiacritics().contains(term));

      pageController.animateToPage(
        index >= 0 ? index : currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.decelerate,
      );

      scrollController.animateTo(
        index * 150,
        duration: const Duration(milliseconds: 300),
        curve: Curves.decelerate,
      );
    });
  }
}
