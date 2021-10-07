import 'package:clean_biblioteca/features/domain/entities/book_entity.dart';
import 'package:clean_biblioteca/features/presenter/controller/home_store.dart';
import 'package:clean_biblioteca/features/presenter/widgets/books_list.dart';
import 'package:clean_biblioteca/features/presenter/widgets/custom_app_bar.dart';
import 'package:clean_biblioteca/features/presenter/widgets/empty_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  @override
  void initState() {
    super.initState();

    store.getBooksFromUser('0');
  }

  Widget _onLoading(BuildContext context) {
    return const Expanded(child: Center(child: CircularProgressIndicator()));
  }

  Widget _onError(BuildContext context, Object? error) {
    return const Expanded(child: Center(child: Text('ERROR')));
  }

  Widget _onSuccess(BuildContext context, List<BookEntity>? list) {
    final books = list ?? [];
    return Expanded(
      child: books.isEmpty
          ? EmptyList(() {
              Modular.to.pushNamed('/book/');
            })
          : BooksList(books, onTapItem: (item) {
              Modular.to.pushNamed('/book/', arguments: item);
            }),
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
    );
  }
}
