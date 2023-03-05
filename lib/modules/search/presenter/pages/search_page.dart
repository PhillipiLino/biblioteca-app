import 'package:biblioteca/modules/search/domain/entities/search_book_entity.dart';
import 'package:biblioteca/modules/search/presenter/store/search_store.dart';
import 'package:biblioteca/modules/search/presenter/widgets/search_book_item.dart';
import 'package:biblioteca_components/biblioteca_components.dart';
import 'package:clean_architecture_utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:pagination_view/pagination_view.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends MainPageState<SearchPage, SearchStore> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }

  _openDetails(SearchBookEntity book) => store.openDetails(book);

  Widget _onLoading(BuildContext context) {
    return const Expanded(child: Center(child: CircularProgressIndicator()));
  }

  Widget _onError(BuildContext context, Object? error) {
    return const Expanded(
      child: EmptyList(
        textColor: Colors.white,
        image: Image(image: AssetImage('assets/images/error.png')),
        title: 'EITA!',
        message: 'Eita, ocorreu um erro. Tente novamente',
      ),
    );
  }

  Widget _onSuccess(BuildContext context, List<SearchBookEntity>? list) {
    final books = list ?? [];

    if (books.isEmpty && _searchController.text.isEmpty) {
      return const Expanded(
        child: EmptyList(
          textColor: Colors.white,
          image: Image(image: AssetImage('assets/images/empty-search.png')),
          title: '',
          message: '',
        ),
      );
    }

    if (books.isEmpty) {
      return const Expanded(
        child: EmptyList(
          textColor: Colors.white,
          image: Image(image: AssetImage('assets/images/term-not-found.png')),
          title: 'Nenhum livro ou autor encontrado',
          message:
              'Desculpe, mas dessa vez não encontramos livro ou autor com o termo buscado. Pode ser sua chance de escrever esse livro!',
        ),
      );
    }

    return Expanded(
      child: PaginationView<SearchBookEntity>(
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
      appBar: CustomAppBar(title: 'Busca', pageContext: context),
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
