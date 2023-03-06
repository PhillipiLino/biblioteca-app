// coverage:ignore-file

import 'package:biblioteca_books_module/biblioteca_books_module.dart';
import 'package:biblioteca_search_module/biblioteca_search_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../app/utils/routes/constants.dart';
import '../profile/profile_module.dart';
import 'presenter/pages/bottom_navigation_page.dart';
import 'presenter/stores/bottom_navigation_page_store.dart';

class MenuModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.singleton((i) => BottomNavigationPageStore(
              i.get(), // AppRouter
              null,
            )),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (_, args) => BottomNavigationPage(args.data),
          transition: TransitionType.fadeIn,
          children: [
            ModuleRoute(
              booksRoute,
              module: BooksModule(booksRoute),
              transition: TransitionType.noTransition,
            ),
            ModuleRoute(
              searchRoute,
              module: SearchModule(),
              transition: TransitionType.noTransition,
            ),
            ModuleRoute(
              profileRoute,
              module: ProfileModule(),
              transition: TransitionType.noTransition,
            ),
            ModuleRoute(
              profileRoute,
              module: ProfileModule(),
              transition: TransitionType.noTransition,
            ),
          ],
        ),
      ];
}
