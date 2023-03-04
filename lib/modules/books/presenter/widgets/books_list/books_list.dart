import 'package:biblioteca/modules/books/domain/entities/book_entity.dart';
import 'package:biblioteca/modules/books/presenter/widgets/books_list/books_list_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../features/presenter/widgets/search_bar.dart';
import '../home_book_item.dart';
import '../shelf_book_item.dart';

class BooksList extends StatefulWidget {
  final List<BookEntity> list;
  final Function(BookEntity) onTapItem;
  final Function(List<BookEntity> updatedList, BookEntity removeditem)
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

class _BooksListState extends State<BooksList> {
  final BooksListStore store = Modular.get<BooksListStore>();
  bool showList = false;
  int currentPage = 0;

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
      actions: [cancelButton, continueButton],
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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Expanded(
                child: SearchBar(
                  hint: 'Digite um livro ou autor',
                  onChanged: (text) {
                    store.searchBookInList(text, widget.list, currentPage);
                  },
                ),
              ),
              IconButton(
                onPressed: () => setState(() => showList = !showList),
                icon: Icon(
                  showList ? Icons.list : Icons.book,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
            child: Stack(
          children: [
            Visibility(
              visible: !showList,
              maintainState: true,
              child: Column(
                children: [
                  Text(
                    widget.list[currentPage].name,
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Stack(
                      children: [
                        const SizedBox(height: 16),
                        PageView.builder(
                          itemCount: widget.list.length,
                          controller: store.pageController,
                          onPageChanged: (value) {
                            setState(() => currentPage = value);
                          },
                          itemBuilder: (context, index) {
                            return ShelfBookItem(
                              widget.list[index],
                              onTap: widget.onTapItem,
                              isFirstBook: index == 0,
                              onTapDelete: (item) async {
                                final result =
                                    await showAlertDialog(context) ?? false;
                                if (!result) return;
                                widget.list.remove(item);
                                await store.deleteBook(item);
                                widget.onDeleteItem(widget.list, item);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: showList,
              maintainState: true,
              child: ListView.builder(
                controller: store.scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                itemCount: widget.list.length,
                itemBuilder: (itemContext, position) => Dismissible(
                  key: Key(widget.list[position].id.toString()),
                  confirmDismiss: (DismissDirection direction) async {
                    if (direction != DismissDirection.endToStart) {
                      return false;
                    }
                    final result = await showAlertDialog(context) ?? false;

                    return result;
                  },
                  onDismissed: (direction) async {
                    final item = widget.list[position];
                    widget.list.removeAt(position);
                    await store.deleteBook(item);
                    widget.onDeleteItem(widget.list, item);
                  },
                  secondaryBackground: Container(
                    color: Colors.white.withOpacity(0.2),
                    padding: const EdgeInsets.all(32.0),
                    child: const Align(
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.delete, size: 32, color: Colors.red),
                    ),
                  ),
                  background: Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  child: HomeBookItem(
                    widget.list[position],
                    onTap: () => widget.onTapItem(widget.list[position]),
                  ),
                ),
              ),
            ),
          ],
        )),
      ],
    );
  }
}
