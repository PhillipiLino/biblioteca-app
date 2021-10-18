import 'package:biblioteca/core/usecase/errors/failures.dart';
import 'package:biblioteca/core/usecase/usecase.dart';
import 'package:biblioteca/core/utils/adapters/dartz_either_adapter.dart';
import 'package:biblioteca/features/domain/entities/user_progress_entity.dart';
import 'package:biblioteca/features/domain/usecases/get_progress_usecase.dart';
import 'package:flutter_triple/flutter_triple.dart';

class ProgressStore extends NotifierStore<Failure, List<UserProgressEntity>> {
  final GetProgressUsecase usecase;

  ProgressStore(this.usecase) : super([]);

  getProgress() async {
    executeEither(() => DartzEitherAdapter.adapter(usecase(NoParams())));
  }
}
