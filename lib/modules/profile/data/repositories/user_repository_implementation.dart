import 'package:biblioteca/core/usecase/errors/exceptions.dart';
import 'package:biblioteca/core/usecase/errors/failures.dart';
import 'package:biblioteca/modules/profile/data/datasources/user_datasource.dart';
import 'package:biblioteca/modules/profile/domain/entities/user_progress_entity.dart';
import 'package:biblioteca/modules/profile/domain/repositories/user_repository.dart';
import 'package:clean_architecture_utils/failures.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImplementation implements IUserRepository {
  final IUserDatasource datasource;

  UserRepositoryImplementation(this.datasource);

  @override
  Future<Either<Failure, List<UserProgressEntity>>> getProgress() async {
    try {
      final result = await datasource.getProgress() ?? [];
      return Right(result);
    } on DatabaseException {
      return const Left(DatabaseFailure());
    }
  }
}
