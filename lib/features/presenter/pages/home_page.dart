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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Meus Livros'),
      body: SafeArea(
        child: Column(children: [
          Container(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                hintText: 'digite o nome do livro',
                fillColor: Colors.grey[200],
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(25.7),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(25.7),
                ),
              ),
              cursorRadius: const Radius.circular(10),
              cursorColor: Colors.grey,
            ),
          ),
          ScopedBuilder(
            store: store,
            onLoading: (_) => const Expanded(
                child: Center(child: CircularProgressIndicator())),
            onState: (_, List<BookEntity>? list) {
              final books = list ?? [];
              return Expanded(
                child: books.isEmpty
                    ? EmptyList(() {})
                    : BooksList(books, onTapItem: (_) {}),
              );
            },
            onError: (_, __) =>
                const Expanded(child: Center(child: Text('ERROR'))),
          ),
        ]),
      ),
    );
  }
}
