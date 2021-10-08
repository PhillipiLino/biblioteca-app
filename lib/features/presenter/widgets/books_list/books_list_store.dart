import 'package:clean_biblioteca/core/usecase/errors/failures.dart';
import 'package:clean_biblioteca/core/utils/adapters/dartz_either_adapter.dart';
import 'package:clean_biblioteca/features/domain/entities/book_entity.dart';
import 'package:clean_biblioteca/features/domain/usecases/delete_book_usecase.dart';
import 'package:flutter_triple/flutter_triple.dart';

class BooksListStore extends NotifierStore<Failure, bool> {
  final DeleteBookUsecase usecase;

  BooksListStore(this.usecase) : super(true);

  deleteBook(BookEntity book) async {
    executeEither(() => DartzEitherAdapter.adapter(usecase(book)));
  }
}
