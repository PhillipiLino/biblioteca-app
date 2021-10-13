import 'package:clean_biblioteca/core/usecase/errors/failures.dart';
import 'package:clean_biblioteca/core/usecase/usecase.dart';
import 'package:clean_biblioteca/features/domain/entities/user_progress_entity.dart';
import 'package:clean_biblioteca/features/domain/repositories/books_repository.dart';
import 'package:dartz/dartz.dart';

class GetProgressUsecase
    implements Usecase<List<UserProgressEntity>, NoParams> {
  final IBooksRepository repository;

  GetProgressUsecase(this.repository);

  @override
  Future<Either<Failure, List<UserProgressEntity>>> call(NoParams params) {
    return repository.getProgress();
  }
}
