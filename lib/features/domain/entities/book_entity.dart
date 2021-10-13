import 'package:clean_biblioteca/features/data/models/book_model.dart';
import 'package:equatable/equatable.dart';

class BookEntity extends Equatable {
  final int? id;
  final String name;
  final String author;
  final int pages;
  final int readPages;
  final int stars;
  final String? imagePath;
  late final double progress;
  late final String percentage;

  BookEntity({
    required this.id,
    required this.name,
    required this.author,
    required this.pages,
    required this.readPages,
    required this.stars,
    this.imagePath,
  }) {
    final percent = readPages == 0
        ? 0
        : readPages > pages
            ? 100
            : (readPages * 100) / pages;

    percentage = '${percent.toStringAsFixed(0)}%';
    progress = readPages == 0 ? 0 : percent / 100;
  }

  BookModel toModel() => BookModel(
        databaseId: id,
        name: name,
        author: author,
        pages: pages,
        readPages: readPages,
        stars: stars,
        imagePath: imagePath,
        userId: '0',
        updatedAt: DateTime.now(),
      );

  @override
  List<Object?> get props => [
        id,
        name,
        author,
        pages,
        readPages,
        imagePath,
        stars,
        progress,
        percentage,
      ];
}
