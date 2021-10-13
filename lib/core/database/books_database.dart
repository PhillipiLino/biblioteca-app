import 'dart:async';
import 'package:clean_biblioteca/features/data/models/book_model.dart';
import 'package:clean_biblioteca/features/data/models/user_progress_model.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'book_dao.dart';

part 'books_database.g.dart'; // the generated code will be there

@TypeConverters([DateTimeConverter])
@Database(version: 2, entities: [BookModel, UserProgressModel])
abstract class BooksDatabase extends FloorDatabase {
  IBooksDao get bookDao;
}

class DateTimeConverter extends TypeConverter<DateTime, int> {
  @override
  DateTime decode(int databaseValue) {
    return DateTime.fromMillisecondsSinceEpoch(databaseValue);
  }

  @override
  int encode(DateTime value) {
    return value.millisecondsSinceEpoch;
  }
}
