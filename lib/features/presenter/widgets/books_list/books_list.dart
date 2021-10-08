import 'package:clean_biblioteca/features/domain/entities/book_entity.dart';
import 'package:clean_biblioteca/features/presenter/widgets/books_list/books_list_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../home_book_item.dart';

class BooksList extends StatefulWidget {
  final List<BookEntity> list;
  final Function(BookEntity) onTapItem;
  final Function(List<BookEntity> updatedList, int removedPosition)
      onDeleteItem;

  const BooksList(
    this.list, {
    required this.onTapItem,
    required this.onDeleteItem,
    Key? key,
  }) : super(key: key);

  @override
  State<BooksList> createState() => _BooksListState();
}

class _BooksListState extends ModularState<BooksList, BooksListStore> {
  late List<BookEntity> list;

  @override
  void initState() {
    super.initState();
    list = widget.list;
  }

  Future<bool?> showAlertDialog(BuildContext context) async {
    Widget cancelButton = TextButton(
      child: const Text('Não'),
      onPressed: () => Modular.to.pop(false),
    );
    Widget continueButton = TextButton(
      child: const Text('Sim'),
      onPressed: () => Modular.to.pop(true),
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
          await store.deleteBook(list[position]);
          list.removeAt(position);
          widget.onDeleteItem(list, position);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('${list[position].name} Deletado com sucesso')));
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
          onTap: () => widget.onTapItem(list[position]),
        ),
      ),
    );
  }
}
