import 'package:biblioteca/core/utils/adapters/book_adapter.dart';
import 'package:biblioteca/modules/search/domain/entities/search_book_entity.dart';
import 'package:biblioteca/modules/search/presenter/controller/search_store.dart';
import 'package:biblioteca/features/presenter/widgets/custom_app_bar.dart';
import 'package:biblioteca/features/presenter/widgets/search_bar.dart';
import 'package:biblioteca/modules/search/presenter/widgets/search_book_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:pagination_view/pagination_view.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends ModularState<SearchPage, SearchStore> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }

  _openDetails(SearchBookEntity book) {
    Modular.to.pushNamed('/menu/books/details/', arguments: book.toDetails());
  }

  Widget _onLoading(BuildContext context) {
    return const Expanded(child: Center(child: CircularProgressIndicator()));
  }

  Widget _onError(BuildContext context, Object? error) {
    return const Expanded(child: Center(child: Text('ERROR')));
  }

  Widget _onSuccess(BuildContext context, List<SearchBookEntity>? list) {
    final books = list ?? [];
    final listIsEmpty = books.isEmpty;

    return Expanded(
      child: listIsEmpty
          ? const Center(child: Text('Nenhum resultado encontrado'))
          : PaginationView<SearchBookEntity>(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              preloadedItems: const [],
              itemBuilder:
                  (BuildContext context, SearchBookEntity book, int position) =>
                      SearchBookItem(
                book,
                position,
                onTap: () => _openDetails(book),
              ),
              pageFetch: (position) {
                return store.paginate(_searchController.text, position);
              },
              onError: (dynamic error) => const Center(
                child: Text('Ocorreu um erro inesperado'),
              ),
              onEmpty: const Center(
                child: Text('Nenhum resultado encontrado'),
              ),
              bottomLoader: const Center(
                child: CircularProgressIndicator(),
              ),
              initialLoader: const Center(
                child: CircularProgressIndicator(),
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
