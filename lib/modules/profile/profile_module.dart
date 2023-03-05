import 'package:biblioteca/modules/profile/data/datasources/database_datasource_implementation.dart';
import 'package:biblioteca/modules/profile/data/repositories/user_repository_implementation.dart';
import 'package:biblioteca/modules/profile/domain/usecases/get_progress_usecase.dart';
import 'package:biblioteca/modules/profile/presenter/controllers/progress_store.dart';
import 'package:biblioteca/modules/profile/presenter/pages/progress_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProfileModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => ProgressStore(i(), i())),
    Bind((i) => GetProgressUsecase(i())),
    Bind((i) => UserRepositoryImplementation(i())),
    Bind((i) => DatabaseDataSourceImplementation(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => const ProgressPage(),
    ),
  ];
}
