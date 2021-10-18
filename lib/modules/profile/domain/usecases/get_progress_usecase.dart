import 'package:biblioteca/core/usecase/errors/failures.dart';
import 'package:biblioteca/core/usecase/usecase.dart';
import 'package:biblioteca/modules/profile/domain/entities/user_progress_entity.dart';
import 'package:biblioteca/modules/profile/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class GetProgressUsecase
    implements Usecase<List<UserProgressEntity>, NoParams> {
  final IUserRepository repository;

  GetProgressUsecase(this.repository);

  @override
  Future<Either<Failure, List<UserProgressEntity>>> call(NoParams params) {
    return repository.getProgress();
  }
}
