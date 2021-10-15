import 'package:biblioteca/modules/books/domain/entities/book_entity.dart';
import 'package:biblioteca/modules/books/presenter/widgets/books_list/books_list_store.dart';
import 'package:biblioteca/modules/books/presenter/widgets/home_book_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BooksList extends StatelessWidget {
  final BooksListStore store = Modular.get<BooksListStore>();
  final List<BookEntity> list;
  final Function(BookEntity) onTapItem;
  final Function(List<BookEntity> updatedList, BookEntity removeditem)
      onDeleteItem;

  BooksList(
    this.list, {
    required this.onTapItem,
    required this.onDeleteItem,
    Key? key,
  }) : super(key: key);

  Future<bool?> showAlertDialog(BuildContext context) async {
    Widget cancelButton = TextButton(
      child: const Text('Não'),
      onPressed: () => store.closeDialog(false),
    );
    Widget continueButton = TextButton(
      child: const Text('Sim'),
      onPressed: () => store.closeDialog(true),
    );

    AlertDialog alert = AlertDialog(
      title: const Text('Excluir livro?'),
      content: const Text(
          'Você deseja realmente excluir esse livro da sua biblioteca?'),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    final teste = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );

    return teste;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      physics:
          const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      itemCount: list.length,
      itemBuilder: (itemContext, position) => Dismissible(
        key: Key(list[position].id.toString()),
        confirmDismiss: (DismissDirection direction) async {
          if (direction != DismissDirection.endToStart) return false;
          final result = await showAlertDialog(context) ?? false;

          return result;
        },
        onDismissed: (direction) async {
          final item = list[position];
          list.removeAt(position);
          await store.deleteBook(item);
          onDeleteItem(list, item);
        },
        secondaryBackground: Container(
          color: Colors.grey[200],
          padding: const EdgeInsets.all(32.0),
          child: const Align(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.delete,
              size: 32,
              color: Colors.red,
            ),
          ),
        ),
        background: Container(color: Colors.grey[200]),
        child: HomeBookItem(
          list[position],
          onTap: () => onTapItem(list[position]),
        ),
      ),
    );
  }
}
