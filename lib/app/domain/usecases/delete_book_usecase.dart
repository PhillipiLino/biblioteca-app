import 'package:biblioteca/app/domain/repositories/books_repository.dart';
import 'package:biblioteca_books_module/biblioteca_books_module.dart';
import 'package:clean_architecture_utils/failures.dart';
import 'package:clean_architecture_utils/usecase.dart';

class DeleteBookUsecase implements Usecase<bool, BookEntity> {
  final IBooksRepository repository;

  DeleteBookUsecase(this.repository);

  @override
  Future<Either<Failure, bool>> call(BookEntity params) {
    return repository.deleteBook(params);
  }
}
