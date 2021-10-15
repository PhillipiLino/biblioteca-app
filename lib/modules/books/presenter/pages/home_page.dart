import 'package:biblioteca/modules/books/domain/entities/book_entity.dart';
import 'package:biblioteca/modules/books/presenter/controllers/home_store.dart';
import 'package:biblioteca/modules/books/presenter/widgets/books_list/books_list.dart';
import 'package:biblioteca/features/presenter/widgets/custom_app_bar.dart';
import 'package:biblioteca/features/presenter/widgets/empty_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  bool listIsEmpty = false;
  List<BookEntity> books = [];

  @override
  void initState() {
    super.initState();

    _refresh();
  }

  Future _refresh() async => store.getBooks();

  _openDetails([BookEntity? book]) {
    Modular.to.pushNamed('/menu/books/details/', arguments: book).then((value) {
      if ((value as bool? ?? false)) _refresh();
    });
  }

  Widget _onLoading(BuildContext context) {
    return const Expanded(child: Center(child: CircularProgressIndicator()));
  }

  Widget _onError(BuildContext context, Object? error) {
    return const Expanded(child: Center(child: Text('ERROR')));
  }

  Widget _onSuccess(BuildContext context, List<BookEntity>? list) {
    books = list ?? [];
    listIsEmpty = books.isEmpty;
    store.setPersistentList(books);

    return Expanded(
      child: books.isEmpty
          ? EmptyList(_openDetails)
          : RefreshIndicator(
              onRefresh: _refresh,
              child: BooksList(
                books,
                onTapItem: _openDetails,
                onDeleteItem: (list, item) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('${item.name} deletado com sucesso')));
                  _refresh();
                },
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Meus Livros'),
      body: SafeArea(
        child: Column(children: [
          Container(height: 20),
          ScopedBuilder(
            store: store,
            onLoading: _onLoading,
            onState: _onSuccess,
            onError: _onError,
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
        onPressed: _openDetails,
      ),
    );
  }
}
