import 'dart:convert';

import 'package:biblioteca/core/database/book_dao.dart';
import 'package:biblioteca/core/http_client/http_client.dart';
import 'package:biblioteca/core/usecase/errors/exceptions.dart';
import 'package:biblioteca/core/utils/keys/google_api_keys.dart';
import 'package:biblioteca/features/data/datasources/books_datasource.dart';
import 'package:biblioteca/features/data/endpoints/google_endpoints.dart';
import 'package:biblioteca/features/data/models/book_model.dart';
import 'package:biblioteca/features/data/models/google_search_model.dart';
import 'package:biblioteca/features/data/models/user_progress_model.dart';

class DatabaseDataSourceImplementation implements IBooksDatasource {
  final IBooksDao dao;
  final HttpClient client;

  DatabaseDataSourceImplementation(this.dao, this.client);

  @override
  Future<List<BookModel>> getBooksFromUser(String userId) async {
    try {
      return dao.getAllBooksFromUser(userId);
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<void> createBook(BookModel book) async {
    try {
      return dao.insertBook(book);
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<void> deleteBook(BookModel book) async {
    try {
      return dao.deleteBook(book);
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<List<UserProgressModel>?> getProgress() async {
    try {
      return dao.getProgress();
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<GoogleSearchModel> searchBooks(String filter) async {
    final response = await client.get(
      GoogleEndpoints.apod(
        NasaApiKeys.apiKey,
        filter,
      ),
    );

    if (response.statusCode == 200) {
      return GoogleSearchModel.fromJson(jsonDecode(response.data));
    }

    throw ServerException();
  }
}
