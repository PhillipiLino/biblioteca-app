import 'package:biblioteca/modules/profile/data/models/user_progress_model.dart';

abstract class IUserDatasource {
  Future<List<UserProgressModel>?> getProgress();
}
