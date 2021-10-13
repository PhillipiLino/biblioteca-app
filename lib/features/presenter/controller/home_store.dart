import 'package:biblioteca/core/usecase/errors/failures.dart';
import 'package:biblioteca/core/utils/adapters/dartz_either_adapter.dart';
import 'package:biblioteca/features/domain/entities/book_entity.dart';
import 'package:biblioteca/features/domain/usecases/get_user_books_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

class HomeStore extends NotifierStore<Failure, List<BookEntity>> {
  final GetUserBooksUsecase usecase;

  HomeStore(this.usecase) : super(Modular.get<PersistList>().list);

  getBooksFromUser(String userId) async {
    executeEither(() => DartzEitherAdapter.adapter(usecase(userId)));
  }
}

class PersistList {
  List<BookEntity> list = [];
}
