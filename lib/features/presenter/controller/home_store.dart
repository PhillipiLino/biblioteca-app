import 'package:clean_biblioteca/core/usecase/errors/failures.dart';
import 'package:clean_biblioteca/core/utils/adapters/dartz_either_adapter.dart';
import 'package:clean_biblioteca/features/domain/entities/book_entity.dart';
import 'package:clean_biblioteca/features/domain/usecases/get_user_books_usecase.dart';
import 'package:flutter_triple/flutter_triple.dart';

class HomeStore extends NotifierStore<Failure, List<BookEntity>> {
  final GetUserBooksUsecase usecase;

  HomeStore(this.usecase) : super(const []);

  getBooksFromUser(String userId) async {
    executeEither(() => DartzEitherAdapter.adapter(usecase(userId)));
  }
}
