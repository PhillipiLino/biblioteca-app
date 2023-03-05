import 'dart:developer';

import 'package:biblioteca_auth_module/biblioteca_auth_module.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../modules/menu/presenter/utils/bottom_navigation_item.dart';
import '../domain/entities/user_auth.dart';
import 'auth_store.dart';
import 'routes/app_routes.dart';

class LoginCallback extends ILoginCallback {
  final AuthStore authStore;
  final AppRoutes routes;

  LoginCallback(this.authStore, this.routes);

  @override
  onLoginFailure(Object? error, StackTrace stack) {}

  @override
  onLoginSuccess(UserAuthInfo info) async {
    final credential = GoogleAuthProvider.credential(
      accessToken: info.accessToken,
      idToken: info.idToken,
    );

    FirebaseAuth.instance.signInWithCredential(credential).then((value) async {
      final name = value.user?.displayName ?? '';
      final uid = value.user?.uid ?? '';
      final email = value.user?.email ?? '';

      final user = UserAuth(uid: uid, name: name, email: email);
      await authStore.setUser(user);
      routes.goToMenu(BottomNavigationItem.books, null);
    }).onError((error, stackTrace) {
      log(error.toString());
    });
  }
}
