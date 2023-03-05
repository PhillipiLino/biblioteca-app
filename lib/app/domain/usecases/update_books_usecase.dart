import 'package:biblioteca/app/domain/repositories/books_repository.dart';
import 'package:biblioteca_books_module/biblioteca_books_module.dart';
import 'package:clean_architecture_utils/failures.dart';
import 'package:clean_architecture_utils/usecase.dart';

class UpdateBooksUsecase implements Usecase<bool, List<BookEntity>> {
  final IBooksRepository repository;

  UpdateBooksUsecase(this.repository);

  @override
  Future<Either<Failure, bool>> call(List<BookEntity> params) {
    return repository.updateBooks(params);
  }
}
