import 'package:biblioteca/modules/books/domain/entities/book_entity.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'books_table')
class BookModel extends BookEntity {
  @PrimaryKey(autoGenerate: true)
  final int? databaseId;

  @ColumnInfo(name: 'user_id')
  final String userId;

  @ColumnInfo(name: 'updated_at')
  final DateTime? updatedAt;

  BookModel({
    this.databaseId,
    required String name,
    required String author,
    required int pages,
    required int readPages,
    required int stars,
    required String? imagePath,
    required this.userId,
    required this.updatedAt,
  }) : super(
          id: databaseId,
          name: name,
          author: author,
          pages: pages,
          readPages: readPages,
          stars: stars,
          imagePath: imagePath,
        );

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        databaseId: json['id'],
        name: json['name'],
        author: json['author'],
        pages: json['pages'],
        readPages: json['readPages'],
        stars: json['stars'],
        imagePath: json['imagePath'],
        userId: json['user_id'],
        updatedAt: DateTime.parse(json['updated_at']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'author': author,
        'pages': pages,
        'readPages': readPages,
        'stars': stars,
        'imagePath': imagePath,
        'user_id': userId,
        'updated_at': updatedAt.toString(),
      };
}
