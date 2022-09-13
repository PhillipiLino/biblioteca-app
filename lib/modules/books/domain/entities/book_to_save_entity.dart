import 'package:biblioteca/modules/books/domain/entities/book_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class BookToSaveEntity extends Equatable {
  final BookEntity book;
  final XFile? imageFile;

  const BookToSaveEntity({
    required this.book,
    required this.imageFile,
  });

  @override
  List<Object?> get props => [
        book,
        imageFile,
      ];
}
