import 'dart:async';
import 'package:biblioteca/core/database/type_converters/date_time_converter.dart';
import 'package:biblioteca/modules/books/data/models/book_model.dart';
import 'package:biblioteca/modules/profile/data/models/user_progress_model.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'book_dao.dart';

part 'books_database.g.dart'; // the generated code will be there

@TypeConverters([DateTimeConverter])
@Database(version: 2, entities: [BookModel, UserProgressModel])
abstract class BooksDatabase extends FloorDatabase {
  IBooksDao get bookDao;
}
