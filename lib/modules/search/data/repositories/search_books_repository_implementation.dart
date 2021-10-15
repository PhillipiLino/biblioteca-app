import 'package:biblioteca/core/usecase/errors/exceptions.dart';
import 'package:biblioteca/core/usecase/errors/failures.dart';
import 'package:biblioteca/modules/search/data/datasources/search_books_datasource.dart';
import 'package:biblioteca/modules/search/domain/entities/search_book_entity.dart';
import 'package:biblioteca/modules/search/domain/entities/search_params.dart';
import 'package:biblioteca/modules/search/domain/repositories/books_repository.dart';
import 'package:dartz/dartz.dart';

class SearchBooksRepositoryImplementation implements ISearchRepository {
  final ISearchBooksDatasource datasource;

  SearchBooksRepositoryImplementation(this.datasource);

  @override
  Future<Either<Failure, List<SearchBookEntity>>> searchBooks(
      SearchParams params) async {
    try {
      final result = await datasource.searchBooks(params);
      return Right(result.items);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
