import 'package:biblioteca/modules/books/domain/entities/book_to_save_entity.dart';
import 'package:biblioteca/modules/books/domain/repositories/books_repository.dart';
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
