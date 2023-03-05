import 'package:biblioteca/auth_store.dart';
import 'package:biblioteca/core/utils/routes/app_routes.dart';
import 'package:biblioteca/modules/profile/domain/entities/user_progress_entity.dart';
import 'package:biblioteca/modules/profile/domain/usecases/get_progress_usecase.dart';
import 'package:clean_architecture_utils/failures.dart';
import 'package:clean_architecture_utils/usecase.dart';
import 'package:flutter_triple/flutter_triple.dart';

class ProgressStore extends NotifierStore<Failure, List<UserProgressEntity>> {
  final GetProgressUsecase usecase;
  final AuthStore authStore;
  final AppRoutes routes;

  ProgressStore(this.usecase, this.authStore, this.routes) : super([]);

  getProgress() async {
    executeEither(() => DartzEitherAdapter.adapter(usecase(NoParams())));
  }

  logout() {
    authStore.clearAuthData();
    routes.goToLogin();
  }
}
