import 'package:biblioteca/features/domain/entities/book_entity.dart';
import 'package:biblioteca/features/presenter/controller/home_store.dart';
import 'package:biblioteca/features/presenter/controller/search_store.dart';
import 'package:biblioteca/features/presenter/widgets/custom_app_bar.dart';
import 'package:biblioteca/features/presenter/widgets/search_bar.dart';
import 'package:biblioteca/features/presenter/widgets/search_book_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends ModularState<SearchPage, SearchStore> {
  final List<BookEntity> list = Modular.get<PersistList>().list;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }

  _openDetails([BookEntity? book]) {
    Modular.to.pushNamed('/book/', arguments: book);
  }

  Widget _onLoading(BuildContext context) {
    return const Expanded(child: Center(child: CircularProgressIndicator()));
  }

  Widget _onError(BuildContext context, Object? error) {
    return const Expanded(child: Center(child: Text('ERROR')));
  }

  Widget _onSuccess(BuildContext context, List<BookEntity>? list) {
    final books = list ?? [];
    final listIsEmpty = books.isEmpty;

    return Expanded(
      child: listIsEmpty
          ? const Center(child: Text('Nenhum resultado encontrado'))
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              itemCount: books.length,
              itemBuilder: (itemContext, position) => SearchBookItem(
                books[position],
                position,
                onTap: () => _openDetails(books[position]),
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    hideKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

    return Scaffold(
      appBar: CustomAppBar(title: 'Busca'),
      body: GestureDetector(
        onTap: hideKeyboard,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SearchBar(
                hint: 'Digite um livro ou autor',
                controller: _searchController,
                onChanged: store.search,
              ),
            ),
            ScopedBuilder(
              store: store,
              onLoading: _onLoading,
              onState: _onSuccess,
              onError: _onError,
            ),
          ],
        ),
      ),
    );
  }
}
