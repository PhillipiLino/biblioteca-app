import 'package:biblioteca/modules/search/domain/entities/search_book_entity.dart';
import 'package:biblioteca/modules/search/domain/entities/search_params.dart';
import 'package:biblioteca/modules/search/domain/repositories/books_repository.dart';
import 'package:biblioteca_network_sdk/google_service.dart';
import 'package:clean_architecture_utils/failures.dart';
import 'package:dartz/dartz.dart';

import '../../../../app/domain/errors/exceptions.dart';

class SearchBooksRepositoryImplementation implements ISearchRepository {
  final GoogleService service;

  SearchBooksRepositoryImplementation(this.service);

  @override
  Future<Either<Failure, List<SearchBookEntity>>> searchBooks(
    SearchParams params,
  ) async {
    try {
      final result = await service.searchBooks(params.toSDK());
      final parsed = result.items
          ?.map((e) => SearchBookEntity.fromGoogleModel(e))
          .toList();
      return Right(parsed ?? []);
    } on ServerException {
      return const Left(ServerFailure(''));
    }
  }
}
