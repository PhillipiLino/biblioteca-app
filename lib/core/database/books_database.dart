import 'dart:async';
import 'package:clean_biblioteca/features/data/models/book_model.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'book_dao.dart';

part 'books_database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [BookModel])
abstract class BooksDatabase extends FloorDatabase {
  IBooksDao get bookDao;
}
