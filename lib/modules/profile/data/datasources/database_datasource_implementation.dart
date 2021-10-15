import 'package:biblioteca/core/database/book_dao.dart';
import 'package:biblioteca/core/usecase/errors/exceptions.dart';
import 'package:biblioteca/modules/profile/data/datasources/user_datasource.dart';
import 'package:biblioteca/modules/profile/data/models/user_progress_model.dart';

class DatabaseDataSourceImplementation implements IUserDatasource {
  final IBooksDao dao;

  DatabaseDataSourceImplementation(this.dao);

  @override
  Future<List<UserProgressModel>?> getProgress() async {
    try {
      return dao.getProgress();
    } catch (e) {
      throw DatabaseException();
    }
  }
}
