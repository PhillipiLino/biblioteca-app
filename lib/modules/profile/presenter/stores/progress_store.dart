import 'package:biblioteca_books_module/biblioteca_books_module.dart';
import 'package:clean_architecture_utils/events.dart';
import 'package:clean_architecture_utils/usecase.dart';
import 'package:clean_architecture_utils/utils.dart';

import '../../../../app/domain/usecases/get_progress_usecase.dart';
import '../../../../app/utils/auth_store.dart';
import '../../../../app/utils/routes/app_routes.dart';
import '../../domain/entities/user_progress_entity.dart';

class ProgressStore extends MainStore<List<UserProgressEntity>> {
  final GetProgressUsecase usecase;
  final AuthStore authStore;
  final AppRoutes routes;

  ProgressStore(
    this.usecase,
    this.authStore,
    this.routes,
    EventBus? eventBus,
  ) : super(eventBus, []);

  getProgress() async {
    executeEither(() => DartzEitherAdapter.adapter(usecase(NoParams())));
  }

  logout() {
    authStore.clearAuthData();
    routes.goToLogin();
  }

  downloadBooks() {
    eventBus?.fire(BooksModuleEvents.downloadBooks);
  }
}
