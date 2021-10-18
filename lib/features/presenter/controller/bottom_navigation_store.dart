import 'package:biblioteca/core/usecase/errors/failures.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

class BottomNavigationStore extends NotifierStore<Failure, int> {
  BottomNavigationStore() : super(0);

  setRoute(String route) {
    switch (route) {
      case '/home/':
        update(0);
        break;
      case '/progress/':
        update(1);
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
        _goToProgress();
        break;
      default:
    }
  }

  _goToHome() => Modular.to.navigate('/menu/home/');

  _goToProgress() => Modular.to.navigate('/menu/progress/');
}
