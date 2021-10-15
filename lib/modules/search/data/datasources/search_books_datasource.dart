import 'package:biblioteca/modules/search/data/models/google_search_model.dart';
import 'package:biblioteca/modules/search/domain/entities/search_params.dart';

abstract class ISearchBooksDatasource {
  Future<GoogleSearchModel> searchBooks(SearchParams params);
}
