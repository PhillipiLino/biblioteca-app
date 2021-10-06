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
    final percent = readPages == 0 ? 0 : pages ~/ readPages;
    percentage = '$percent%';
    progress = readPages == 0 ? 0 : percent / 100;
  }

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
