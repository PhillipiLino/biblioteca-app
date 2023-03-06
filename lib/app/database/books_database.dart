// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:biblioteca/app/database/models/user_progress_model.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'book_dao.dart';
import 'models/book_model.dart';
import 'type_converters/date_time_converter.dart';

part 'books_database.g.dart'; // the generated code will be there

@TypeConverters([DateTimeConverter])
@Database(version: 2, entities: [BookModel, UserProgressModel])
abstract class BooksDatabase extends FloorDatabase {
  IBooksDao get bookDao;
}
