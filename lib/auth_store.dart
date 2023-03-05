import 'package:biblioteca/app_module.dart';
import 'package:clean_architecture_utils/events.dart';
import 'package:clean_architecture_utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'preferences_manager.dart';

class AuthStore extends MainStore<UserAuth> {
  final PreferencesManager _prefs;
  // final TrackersHelper _trackers;
  static const _userPrefsKey = 'user';

  AuthStore(
    this._prefs,
    // this._trackers,
    EventBus? eventBus,
  ) : super(
            eventBus,
            const UserAuth(
              uid: '',
              name: '',
              email: '',
            ));

  setUser(UserAuth value) async {
    update(value);
    _prefs.setDict(_userPrefsKey, value.toJson());
  }

  clearAuthData() async {
    update(const UserAuth(uid: '', name: '', email: ''));
    _prefs.removeKey(_userPrefsKey);
    FirebaseAuth.instance.signOut();
  }

  Future<UserAuth?> getUser() async {
    final userDict = await _prefs.getDict(_userPrefsKey);
    if (userDict == null) return null;

    final user = UserAuth.fromJson(userDict);

    setUser(user);
    return user;
  }
}
