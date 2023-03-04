import 'package:biblioteca/modules/profile/domain/entities/user_progress_entity.dart';
import 'package:clean_architecture_utils/failures.dart';
import 'package:dartz/dartz.dart';

abstract class IUserRepository {
  Future<Either<Failure, List<UserProgressEntity>>> getProgress();
}
