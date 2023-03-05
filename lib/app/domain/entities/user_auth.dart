import 'package:commons_tools_sdk/commons_tools_sdk.dart';
import 'package:equatable/equatable.dart';

class UserAuth extends Equatable {
  final String uid;
  final String name;
  final String email;

  static const String _uid = 'uid';
  static const String _name = 'name';
  static const String _email = 'email';

  const UserAuth({
    required this.uid,
    required this.name,
    required this.email,
  });

  UserAuth.fromJson(Map<String, dynamic> json)
      : uid = castOrNull(json[_uid]),
        name = castOrNull(json[_name]),
        email = castOrNull(json[_email]);

  Map<String, dynamic> toJson() => {
        _uid: uid,
        _name: name,
        _email: email,
      };

  @override
  List<Object?> get props => [
        uid,
        name,
        email,
      ];
}
