import 'package:biblioteca/features/stores/splash_page_store.dart';
import 'package:clean_architecture_utils/utils.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends MainPageState<SplashPage, SplashPageStore> {
  @override
  void initState() {
    super.initState();
    store.checkUser();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
