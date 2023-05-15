import 'package:biblioteca/app/utils/routes/app_routes.dart';
import 'package:biblioteca/modules/menu/presenter/utils/bottom_navigation_item.dart';

import '../../app/utils/auth_store.dart';

class SplashPageStore {
  final AppRoutes _routes;
  final AuthStore _authStore;

  SplashPageStore(this._routes, this._authStore);

  checkUser() async {
    final loggedUser = await _authStore.getUser();

    if (loggedUser == null) {
      return _routes.goToLogin();
    }

    _routes.goToMenu(BottomNavigationItem.books, null);
  }
}
