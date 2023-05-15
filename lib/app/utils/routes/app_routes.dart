import 'package:biblioteca/app/utils/routes/constants.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../modules/menu/presenter/utils/bottom_navigation_item.dart';
import '../../../modules/menu/presenter/utils/bottom_navigation_page_data.dart';

class AppRoutes {
  goToMenu(BottomNavigationItem item, dynamic childData) =>
      Modular.to.navigate('$menuRoute${item.route}/',
          arguments: BottomNavigationPageData(item, childData));

  goToLogin() => Modular.to.navigate(loginRoute);
}
