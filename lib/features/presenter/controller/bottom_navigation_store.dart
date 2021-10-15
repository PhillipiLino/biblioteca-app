import 'package:biblioteca/core/usecase/errors/failures.dart';
import 'package:biblioteca/core/utils/routes/app_routes.dart';
import 'package:biblioteca/core/utils/routes/constants.dart';
import 'package:flutter_triple/flutter_triple.dart';

class BottomNavigationStore extends NotifierStore<Failure, int> {
  final AppRoutes _routes;

  BottomNavigationStore(this._routes) : super(0);

  setRoute(String route) {
    switch (route) {
      case booksRoute:
        update(0);
        break;
      case searchRoute:
        update(1);
        break;
      case profileRoute:
        update(2);
        break;
      default:
        update(0);
    }
  }

  goToPage(int index) {
    if (index == state) return;
    update(index);

    switch (index) {
      case 0:
        _goToBooks();
        break;
      case 1:
        _goToSearch();
        break;
      case 2:
        _goToProgress();
        break;
      default:
    }
  }

  _goToBooks() => _routes.goToMenu(booksRoute);

  _goToSearch() => _routes.goToMenu(searchRoute);

  _goToProgress() => _routes.goToMenu(profileRoute);
}
