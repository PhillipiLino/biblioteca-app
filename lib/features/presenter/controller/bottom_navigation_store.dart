import 'package:biblioteca/core/usecase/errors/failures.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

class BottomNavigationStore extends NotifierStore<Failure, int> {
  BottomNavigationStore() : super(0);

  setRoute(String route) {
    switch (route) {
      case '/books/':
        update(0);
        break;
      case '/search/':
        update(1);
        break;
      case '/profile/':
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
        _goToHome();
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

  _goToHome() => Modular.to.navigate('/menu/books/');

  _goToSearch() => Modular.to.navigate('/menu/search/');

  _goToProgress() => Modular.to.navigate('/menu/profile/');
}
