// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'books_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorBooksDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $BooksDatabaseBuilder databaseBuilder(String name) =>
      $BooksDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $BooksDatabaseBuilder inMemoryDatabaseBuilder() =>
      $BooksDatabaseBuilder(null);
}

class $BooksDatabaseBuilder {
  $BooksDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  $BooksDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  $BooksDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<BooksDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$BooksDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$BooksDatabase extends BooksDatabase {
  _$BooksDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  IBooksDao? _bookDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 2,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `books_table` (`databaseId` INTEGER PRIMARY KEY AUTOINCREMENT, `user_id` TEXT NOT NULL, `updated_at` INTEGER, `id` INTEGER, `name` TEXT NOT NULL, `author` TEXT NOT NULL, `pages` INTEGER NOT NULL, `readPages` INTEGER NOT NULL, `stars` INTEGER NOT NULL, `imagePath` TEXT, `progress` REAL NOT NULL, `percentage` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `books_table` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `totalPages` INTEGER NOT NULL, `totalReadPages` INTEGER NOT NULL, `pagesProgress` REAL NOT NULL, `books` INTEGER NOT NULL, `completedBooks` INTEGER NOT NULL, `booksProgress` REAL NOT NULL, `updatedAt` INTEGER)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  IBooksDao get bookDao {
    return _bookDaoInstance ??= _$IBooksDao(database, changeListener);
  }
}

class _$IBooksDao extends IBooksDao {
  _$IBooksDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _bookModelInsertionAdapter = InsertionAdapter(
            database,
            'books_table',
            (BookModel item) => <String, Object?>{
                  'databaseId': item.databaseId,
                  'user_id': item.userId,
                  'updated_at': _dateTimeConverter.encode(item.updatedAt),
                  'id': item.id,
                  'name': item.name,
                  'author': item.author,
                  'pages': item.pages,
                  'readPages': item.readPages,
                  'stars': item.stars,
                  'imagePath': item.imagePath,
                  'progress': item.progress,
                  'percentage': item.percentage
                }),
        _bookModelDeletionAdapter = DeletionAdapter(
            database,
            'books_table',
            ['databaseId'],
            (BookModel item) => <String, Object?>{
                  'databaseId': item.databaseId,
                  'user_id': item.userId,
                  'updated_at': _dateTimeConverter.encode(item.updatedAt),
                  'id': item.id,
                  'name': item.name,
                  'author': item.author,
                  'pages': item.pages,
                  'readPages': item.readPages,
                  'stars': item.stars,
                  'imagePath': item.imagePath,
                  'progress': item.progress,
                  'percentage': item.percentage
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<BookModel> _bookModelInsertionAdapter;

  final DeletionAdapter<BookModel> _bookModelDeletionAdapter;

  @override
  Future<List<BookModel>> getBooks() async {
    return _queryAdapter.queryList(
        'Select * from books_table ORDER BY updated_at DESC',
        mapper: (Map<String, Object?> row) => BookModel(
            databaseId: row['databaseId'] as int?,
            name: row['name'] as String,
            author: row['author'] as String,
            pages: row['pages'] as int,
            readPages: row['readPages'] as int,
            stars: row['stars'] as int,
            imagePath: row['imagePath'] as String?,
            userId: row['user_id'] as String,
            updatedAt: _dateTimeConverter.decode(row['updated_at'] as int?)));
  }

  @override
  Future<List<UserProgressModel>?> getProgress() async {
    return _queryAdapter.queryList(
        'Select SUM(pages) as totalPages,        Sum(readPages) as totalReadPages,        ((Sum(readPages) * 100.0)/Sum(pages)) as pagesProgress,       Count(*) as books,       Count(case when pages = readPages Then 1 else NULL end) as completedBooks,       ((Count(case when pages = readPages Then 1 else NULL end) * 100.0)/Count(*)) as booksProgress,       max(updated_at) updatedAt from books_table',
        mapper: (Map<String, Object?> row) => UserProgressModel(
            id: row['id'] as int?,
            totalPages: row['totalPages'] as int?,
            totalReadPages: row['totalReadPages'] as int?,
            pagesProgress: row['pagesProgress'] as double?,
            books: row['books'] as int?,
            completedBooks: row['completedBooks'] as int?,
            booksProgress: row['booksProgress'] as double?,
            updatedAt: _dateTimeConverter.decode(row['updatedAt'] as int?)));
  }

  @override
  Future<void> insertBook(BookModel book) async {
    await _bookModelInsertionAdapter.insert(book, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertBooks(List<BookModel> books) async {
    await _bookModelInsertionAdapter.insertList(
        books, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteBook(BookModel book) async {
    await _bookModelDeletionAdapter.delete(book);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
