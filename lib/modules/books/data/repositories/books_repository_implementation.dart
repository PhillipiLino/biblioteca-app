import 'package:biblioteca/core/utils/adapters/book_adapter.dart';
import 'package:biblioteca_books_module/biblioteca_books_module.dart';
import 'package:clean_architecture_utils/failures.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecase/errors/exceptions.dart';
import '../../../../core/usecase/errors/failures.dart';
import '../../../../core/utils/helpers/image_helper.dart';
import '../../domain/repositories/books_repository.dart';
import '../datasources/books_datasource.dart';

class BooksRepositoryImplementation implements IBooksRepository {
  final IBooksDatasource datasource;
  final ImageHelper imageHelper;

  BooksRepositoryImplementation(this.datasource, this.imageHelper);

  @override
  Future<Either<Failure, List<BookEntity>>> getBooks() async {
    try {
      final result = await datasource.getBooks();
      return Right(result);
    } on DatabaseException {
      return const Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> createBook(BookToSaveEntity infoToSave) async {
    try {
      await datasource.createBook(infoToSave.book.toModel());
      if (infoToSave.imageFile != null) {
        await imageHelper.saveImage(
          infoToSave.imageFile!,
          infoToSave.book.imagePath ?? '',
        );
      }

      return const Right(true);
    } on DatabaseException {
      return const Left(DatabaseFailure());
    } on ImageException {
      return const Left(SaveImageFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteBook(BookEntity book) async {
    try {
      await datasource.deleteBook(book.toModel());
      return const Right(true);
    } on DatabaseException {
      return const Left(DatabaseFailure());
    }
  }
}
