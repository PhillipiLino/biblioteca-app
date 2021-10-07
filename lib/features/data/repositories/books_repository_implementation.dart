import 'package:clean_biblioteca/core/usecase/errors/exceptions.dart';
import 'package:clean_biblioteca/core/utils/helpers/image_helper.dart';
import 'package:clean_biblioteca/features/data/datasources/books_datasource.dart';
import 'package:clean_biblioteca/features/domain/entities/book_entity.dart';
import 'package:clean_biblioteca/core/usecase/errors/failures.dart';
import 'package:clean_biblioteca/features/domain/entities/book_to_save_entity.dart';
import 'package:clean_biblioteca/features/domain/repositories/books_repository.dart';
import 'package:dartz/dartz.dart';

class BooksRepositoryImplementation implements IBooksRepository {
  final IBooksDatasource datasource;
  final ImageHelper imageHelper;

  BooksRepositoryImplementation(this.datasource, this.imageHelper);

  @override
  Future<Either<Failure, List<BookEntity>>> getUserBooks(String userId) async {
    try {
      final result = await datasource.getBooksFromUser(userId);
      return Right(result);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> createBook(BookToSaveEntity infoToSave) async {
    try {
      await datasource.createBook(infoToSave.book.toModel());
      if (infoToSave.imageFile != null) {
        final name = 'book_${infoToSave.book.id}';
        await imageHelper.saveImage(infoToSave.imageFile!, name);
      }

      return const Right(true);
    } on DatabaseException {
      return Left(DatabaseFailure());
    } on ImageException {
      return Left(SaveImageFailure());
    }
  }
}
