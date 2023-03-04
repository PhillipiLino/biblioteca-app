import 'package:biblioteca/modules/profile/domain/entities/user_progress_entity.dart';
import 'package:biblioteca/modules/profile/domain/usecases/get_progress_usecase.dart';
import 'package:clean_architecture_utils/failures.dart';
import 'package:clean_architecture_utils/usecase.dart';
import 'package:flutter_triple/flutter_triple.dart';

class ProgressStore extends NotifierStore<Failure, List<UserProgressEntity>> {
  final GetProgressUsecase usecase;

  ProgressStore(this.usecase) : super([]);

  getProgress() async {
    executeEither(() => DartzEitherAdapter.adapter(usecase(NoParams())));
  }
}
