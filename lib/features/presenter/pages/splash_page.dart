import 'package:biblioteca/features/stores/splash_page_store.dart';
import 'package:clean_architecture_utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends MainPageState<SplashPage, SplashPageStore>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'assets/splash.json',
          repeat: false,
          width: MediaQuery.of(context).size.width * 0.7,
          alignment: Alignment.center,
          onLoaded: (composition) {
            _controller
              ..duration = composition.duration
              ..forward().whenComplete(
                () {
                  store.checkUser();
                },
              );
          },
        ),
      ),
    );
  }
}
