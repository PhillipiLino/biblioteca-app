import 'package:biblioteca/features/domain/entities/book_entity.dart';

class GoogleBookModel extends BookEntity {
  final String bookId;

  GoogleBookModel({
    required this.bookId,
    required String name,
    required String author,
    required int pages,
    required int readPages,
    required int stars,
    required String? imagePath,
  }) : super(
          id: int.tryParse(bookId),
          name: name,
          author: author,
          pages: pages,
          readPages: readPages,
          stars: stars,
          imagePath: imagePath,
        );

  factory GoogleBookModel.fromJson(Map<String, dynamic> json) =>
      GoogleBookModel(
        bookId: json['id'],
        name: json['volumeInfo']['title'],
        author: ((json['volumeInfo']['authors'] as List<dynamic>?)?.first
                as String?) ??
            'Unknown',
        pages: json['volumeInfo']?['pageCount'] ?? 0,
        readPages: 0,
        stars: 1,
        imagePath: json['volumeInfo']['imageLinks']?['thumbnail'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'author': author,
        'pages': pages,
        'readPages': readPages,
        'stars': stars,
        'imagePath': imagePath,
      };
}
