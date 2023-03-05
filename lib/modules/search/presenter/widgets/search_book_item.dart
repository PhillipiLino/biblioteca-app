import 'package:biblioteca/modules/search/domain/entities/search_book_entity.dart';
import 'package:biblioteca_components/biblioteca_components.dart';
import 'package:flutter/material.dart';

class SearchBookItem extends StatelessWidget {
  final int position;
  final SearchBookEntity book;
  final Function onTap;

  const SearchBookItem(
    this.book,
    this.position, {
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap as Function(),
        child: SizedBox(
          height: 150,
          child: IntrinsicWidth(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 130,
                  width: 90,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: BookImage(book.imagePath ?? ''),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.name,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: MainTextStyles.bodyMediumBold.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        book.author,
                        style: MainTextStyles.bodySmallRegular.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Total de páginas: ${book.pages}',
                        style: MainTextStyles.bodySmallRegular.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
