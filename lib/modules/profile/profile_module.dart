import 'package:biblioteca/app/domain/usecases/get_progress_usecase.dart';
import 'package:biblioteca/modules/profile/presenter/pages/progress_page.dart';
import 'package:biblioteca/modules/profile/presenter/stores/progress_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProfileModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => ProgressStore(
          i(),
          i(),
          i(),
          i(),
        )),
    Bind((i) => GetProgressUsecase(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => const ProgressPage(),
    ),
  ];
}
