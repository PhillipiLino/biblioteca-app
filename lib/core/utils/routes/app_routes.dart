import 'package:biblioteca/core/utils/routes/constants.dart';
import 'package:biblioteca/modules/books/domain/entities/book_entity.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../modules/menu/presenter/utils/bottom_navigation_item.dart';
import '../../../modules/menu/presenter/utils/bottom_navigation_page_data.dart';

class AppRoutes {
  openDetails([BookEntity? book]) => Modular.to.pushNamed(
        '$menuRoute$booksRoute$detailsRoute',
        arguments: book,
      );

  goToMenu(BottomNavigationItem item, dynamic childData) =>
      Modular.to.navigate('$menuRoute${item.route}/',
          arguments: BottomNavigationPageData(item, childData));
}
