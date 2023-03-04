import 'package:biblioteca/app_module.dart';
import 'package:biblioteca/core/utils/routes/app_routes.dart';
import 'package:biblioteca/modules/menu/presenter/utils/bottom_navigation_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    checkModule();
  }

  checkModule() async {
    await Modular.isModuleReady<AppModule>();
    AppRoutes().goToMenu(BottomNavigationItem.books, null);
  }

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
