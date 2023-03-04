import 'package:flutter/material.dart';

import '../../../../features/presenter/widgets/book_image.dart';
import '../../domain/entities/book_entity.dart';

class ShelfBookItem extends StatelessWidget {
  final BookEntity book;
  final ValueChanged<BookEntity> onTap;
  final ValueChanged<BookEntity>? onTapDelete;
  final bool isFirstBook;

  const ShelfBookItem(
    this.book, {
    required this.isFirstBook,
    required this.onTap,
    this.onTapDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mockupName = isFirstBook ? 'first_book_mockup' : 'book_mockup';
    return GestureDetector(
      onTap: () => onTap(book),
      child: SizedBox(
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/$mockupName.png',
                    filterQuality: FilterQuality.high,
                    isAntiAlias: true,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: const EdgeInsets.only(top: 6),
                      margin: const EdgeInsets.only(right: 11),
                      height: MediaQuery.of(context).size.height * 0.355,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: BookImage(book.imagePath ?? ''),
                    ),
                  ),
                ],
              ),
            ),
            if (onTapDelete != null)
              Positioned(
                right: 8,
                top: 4,
                child: FloatingActionButton(
                  onPressed: () {
                    onTapDelete?.call(book);
                  },
                  mini: true,
                  backgroundColor: Colors.amber,
                  child: const Icon(
                    Icons.delete,
                    color: Colors.black,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
