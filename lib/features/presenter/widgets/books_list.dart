import 'package:clean_biblioteca/features/domain/entities/book_entity.dart';
import 'package:flutter/material.dart';

import 'home_book_item.dart';

class BooksList extends StatelessWidget {
  final List<BookEntity> list;
  final Function(BookEntity) onTapItem;

  const BooksList(
    this.list, {
    required this.onTapItem,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics:
          const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      itemCount: list.length,
      itemBuilder: (itemContext, position) => HomeBookItem(
        list[position],
        onTap: () => onTapItem(list[position]),
      ),
    );
  }
}
