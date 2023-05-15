import 'package:biblioteca/app/utils/routes/app_routes.dart';
import 'package:clean_architecture_utils/events.dart';
import 'package:clean_architecture_utils/utils.dart';

import '../utils/bottom_navigation_item.dart';
import '../utils/bottom_navigation_page_data.dart';

class BottomNavigationPageStore extends MainStore<int> {
  final AppRoutes _routes;
  final items = BottomNavigationItem.values;

  BottomNavigationPageStore(
    this._routes,
    EventBus? eventBus,
  ) : super(eventBus, -1);

  setRoute(BottomNavigationPageData data) {
    final selectedItem = data.navigationItem;
    goToPage(selectedItem.index, data.childData);
  }

  goToPage(int index, dynamic data) {
    if (index == state) return;

    update(index);
    _routes.goToMenu(items[index], data);
  }
}
