import 'package:biblioteca/app/domain/repositories/books_repository.dart';
import 'package:biblioteca_books_module/biblioteca_books_module.dart';
import 'package:clean_architecture_utils/failures.dart';
import 'package:clean_architecture_utils/usecase.dart';

class GetBooksUsecase implements Usecase<List<BookEntity>, NoParams> {
  final IBooksRepository repository;

  GetBooksUsecase(this.repository);

  @override
  Future<Either<Failure, List<BookEntity>>> call(NoParams params) {
    return repository.getBooks();
  }
}
