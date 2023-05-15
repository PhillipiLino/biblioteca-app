import 'package:biblioteca/app/domain/repositories/books_repository.dart';
import 'package:biblioteca/modules/profile/domain/entities/user_progress_entity.dart';
import 'package:clean_architecture_utils/failures.dart';
import 'package:clean_architecture_utils/usecase.dart';

class GetProgressUsecase
    implements Usecase<List<UserProgressEntity>, NoParams> {
  final IBooksRepository repository;

  GetProgressUsecase(this.repository);

  @override
  Future<Either<Failure, List<UserProgressEntity>>> call(NoParams params) {
    return repository.getProgress();
  }
}
