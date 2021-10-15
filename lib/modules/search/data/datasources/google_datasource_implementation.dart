import 'dart:convert';
import 'package:biblioteca/core/http_client/http_client.dart';
import 'package:biblioteca/core/usecase/errors/exceptions.dart';
import 'package:biblioteca/core/utils/keys/google_api_keys.dart';
import 'package:biblioteca/modules/search/data/endpoints/google_endpoints.dart';
import 'package:biblioteca/modules/search/data/models/google_search_model.dart';
import 'package:biblioteca/modules/search/domain/entities/search_params.dart';

import 'search_books_datasource.dart';

class GoogleDataSourceImplementation implements ISearchBooksDatasource {
  final HttpClient client;

  GoogleDataSourceImplementation(this.client);

  @override
  Future<GoogleSearchModel> searchBooks(SearchParams params) async {
    final response = await client.get(
      GoogleEndpoints.apod(NasaApiKeys.apiKey, params.filter, params.page),
    );

    if (response.statusCode == 200) {
      return GoogleSearchModel.fromJson(jsonDecode(response.data));
    }

    throw ServerException();
  }
}
