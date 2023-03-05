import 'package:biblioteca/app/domain/repositories/books_repository.dart';
import 'package:biblioteca_books_module/biblioteca_books_module.dart';
import 'package:clean_architecture_utils/failures.dart';
import 'package:clean_architecture_utils/usecase.dart';

class CreateBooksUsecase implements Usecase<bool, BookToSaveEntity> {
  final IBooksRepository repository;

  CreateBooksUsecase(this.repository);

  @override
  Future<Either<Failure, bool>> call(BookToSaveEntity params) {
    return repository.createBook(params);
  }
}
