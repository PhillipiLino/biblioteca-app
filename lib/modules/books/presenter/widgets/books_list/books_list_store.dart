import 'package:biblioteca/core/usecase/errors/failures.dart';
import 'package:biblioteca/core/utils/adapters/dartz_either_adapter.dart';
import 'package:biblioteca/modules/books/domain/entities/book_entity.dart';
import 'package:biblioteca/modules/books/domain/usecases/delete_book_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

class BooksListStore extends NotifierStore<Failure, bool> {
  final DeleteBookUsecase usecase;

  BooksListStore(this.usecase) : super(true);

  deleteBook(BookEntity book) async {
    executeEither(() => DartzEitherAdapter.adapter(usecase(book)));
  }

  closeDialog(bool confirm) => Modular.to.pop(confirm);
}
