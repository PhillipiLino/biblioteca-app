import 'package:clean_biblioteca/core/usecase/errors/failures.dart';
import 'package:clean_biblioteca/features/domain/entities/book_entity.dart';
import 'package:dartz/dartz.dart';

abstract class IBooksRepository {
  Future<Either<Failure, List<BookEntity>>> getUserBooks(String userId);
}
