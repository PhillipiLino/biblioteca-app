import 'package:biblioteca/modules/search/domain/entities/search_book_entity.dart';

class GoogleBookModel extends SearchBookEntity {
  const GoogleBookModel({
    required String id,
    required String name,
    required String author,
    required int pages,
    required int readPages,
    required int stars,
    required String? imagePath,
  }) : super(
          id: id,
          name: name,
          author: author,
          pages: pages,
          imagePath: imagePath,
        );

  factory GoogleBookModel.fromJson(Map<String, dynamic> json) =>
      GoogleBookModel(
        id: json['id'],
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
        'imagePath': imagePath,
      };
}
