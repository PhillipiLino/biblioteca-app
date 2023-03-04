import 'package:biblioteca/features/presenter/widgets/custom_app_bar.dart';
import 'package:biblioteca/features/presenter/widgets/empty_list.dart';
import 'package:biblioteca/modules/books/domain/entities/book_entity.dart';
import 'package:biblioteca/modules/books/presenter/stores/home_store.dart';
import 'package:biblioteca/modules/books/presenter/widgets/books_list/books_list.dart';
import 'package:clean_architecture_utils/utils.dart';
import 'package:commons_tools_sdk/commons_tools_sdk.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/girassol_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends MainPageState<HomePage, HomeStore> {
  bool listIsEmpty = false;
  List<BookEntity> books = [];

  @override
  void initState() {
    super.initState();

    _refresh();
  }

  Future _refresh() async => store.getBooks();

  _openDetails([BookEntity? book]) {
    store.openDetails(book).then((value) {
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
    final accentColor = Theme.of(context).colorScheme.secondary;
    books = list ?? [];
    listIsEmpty = books.isEmpty;
    store.setPersistentList(books);

    final int totalPages = books.fold(
        0, (previousValue, element) => previousValue + element.pages);
    final int readPages = books.fold(
        0, (previousValue, element) => previousValue + element.readPages);

    return books.isEmpty
        ? EmptyList(_openDetails)
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: CustomCard(
                    backgroundColor: accentColor,
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.maxFinite,
                          child: Text(
                            'Meu progresso',
                            style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.white,
                            )),
                          ),
                        ),
                        const SizedBox(height: 12),
                        LinearProgressIndicator(
                          value: readPages / totalPages,
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.maxFinite,
                          child: Text(
                            '$readPages de $totalPages páginas lidas',
                            style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            )),
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: BooksList(
                  books,
                  onTapItem: _openDetails,
                  onDeleteItem: (list, item) => _refresh(),
                ),
              ),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      appBar: CustomAppBar(title: 'Meus Livros'),
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: hideKeyboard,
        behavior: HitTestBehavior.opaque,
        onPanDown: (_) => hideKeyboard(),
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              height: 100,
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(300),
                  bottomRight: Radius.circular(300),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ScopedBuilder(
                store: store,
                onLoading: _onLoading,
                onState: _onSuccess,
                onError: _onError,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        onPressed: _openDetails,
        child: const Icon(Icons.add),
      ),
    );
  }
}
