import '../../../../app/database/book_dao.dart';
import '../../../../app/domain/errors/exceptions.dart';
import '../models/user_progress_model.dart';
import 'user_datasource.dart';

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
