import 'package:biblioteca/features/presenter/widgets/book_image.dart';
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
    books = list ?? [];
    listIsEmpty = books.isEmpty;
    store.setPersistentList(books);

    return Expanded(
      child: books.isEmpty
          ? EmptyList(_openDetails)
          :
          //  ListView.separated(
          //     scrollDirection: Axis.horizontal,
          //     itemCount: books.length,
          //     separatorBuilder: (context, index) => SizedBox(),
          //     itemBuilder: (context, index) {
          //       return BookWidget(
          //         books[index],
          //         onTap: _openDetails,
          //       );
          //     },
          //   )
          RefreshIndicator(
              onRefresh: _refresh,
              child: BooksList(
                books,
                onTapItem: _openDetails,
                onDeleteItem: (list, item) => _refresh(),
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final books = [
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEghQ9U5BF_ahLFlASNuUHVTdYKB9VVvG1BSLkIqNC3TvDWAaF4AhwPlENa4O_qmazIKm3RB3IWU7dvLzosXY_smhAVlvfATxVDOg77pqoxg-FhuQpTQlDSF9S1j2TKuZDRu8o6cNpGvzQ3ghEWEK0l88turjMl0xSG03X1g6-X77dcvq82TDg/s819/miles-morales-spider-man-1-cover.jpg',
      'https://i.pinimg.com/736x/dc/66/64/dc666425b307216596a9b197aa885922.jpg',
      'https://m.media-amazon.com/images/I/911o1h5gIzL.jpg',
    ];

    return Scaffold(
      appBar: CustomAppBar(title: 'Meus Livros'),
      body: SafeArea(
        child: Column(
          children: [
            Container(height: 20),
            // Expanded(
            // child: ListView.separated(
            //   scrollDirection: Axis.horizontal,
            //   itemCount: books.length,
            //   separatorBuilder: (context, index) => SizedBox(),
            //   itemBuilder: (context, index) {
            //     return BookWidget(books[index]);
            //   },
            // ),
            // ),

            ScopedBuilder(
              store: store,
              onLoading: _onLoading,
              onState: _onSuccess,
              onError: _onError,
            ),
          ],
        ),
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

class BookWidget extends StatelessWidget {
  final BookEntity book;
  final ValueChanged<BookEntity> onTap;
  const BookWidget(this.book, {required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(book),
      child: SizedBox(
        width: 280,
        child: Stack(
          children: [
            Image.asset('assets/images/book_mockup.png'),
            Positioned(
              right: 12,
              top: 6,
              bottom: 9,
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  height: 326,
                  width: 220,
                  child: BookImage(book.imagePath ?? ''),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
