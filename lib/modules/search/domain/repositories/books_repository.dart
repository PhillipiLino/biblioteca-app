import 'package:biblioteca/modules/search/domain/entities/search_book_entity.dart';
import 'package:biblioteca/modules/search/domain/entities/search_params.dart';
import 'package:clean_architecture_utils/failures.dart';
import 'package:dartz/dartz.dart';

abstract class ISearchRepository {
  Future<Either<Failure, List<SearchBookEntity>>> searchBooks(
      SearchParams params);
}
