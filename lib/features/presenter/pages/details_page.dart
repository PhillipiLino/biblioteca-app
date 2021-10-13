import 'dart:async';

import 'package:clean_biblioteca/features/domain/entities/book_entity.dart';
import 'package:clean_biblioteca/features/presenter/controller/details_store.dart';
import 'package:clean_biblioteca/features/presenter/widgets/book_image.dart';
import 'package:clean_biblioteca/features/presenter/widgets/custom_app_bar.dart';
import 'package:clean_biblioteca/features/presenter/widgets/default_text_field.dart';
import 'package:clean_biblioteca/features/presenter/widgets/rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';

class DetailsPage extends StatefulWidget {
  final BookEntity? book;

  const DetailsPage(
    this.book, {
    Key? key,
  }) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends ModularState<DetailsPage, DetailsStore> {
  late BookEntity? book;
  int starsNumber = 1;

  final ImagePicker _picker = ImagePicker();
  XFile? pickedImage;
  Timer _timer = Timer(const Duration(milliseconds: 0), () {});

  late BookImage bookImage;

  @override
  void initState() {
    super.initState();
    book = widget.book;
    starsNumber = book?.stars ?? 1;

    store.initTextControllers(book);

    bookImage = BookImage(book?.imagePath ?? '');
  }

  @override
  Widget build(BuildContext context) {
    hideKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

    _removeRead() {
      final pages = int.tryParse(store.readPagesController.text) ?? 0;
      final newValue = pages == 0 ? 0 : pages - 1;
      setState(() => store.readPagesController.text = newValue.toString());
    }

    _addRead() {
      final pages = int.tryParse(store.readPagesController.text) ?? 0;
      setState(() => store.readPagesController.text = (pages + 1).toString());
    }

    _changeRating(int newRating) {
      starsNumber = newRating;
    }

    _timerAction(VoidCallback action) {
      _timer = Timer.periodic(const Duration(milliseconds: 100), (t) {
        action();
      });
    }

    final bookImageWidget = Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 120),
      child: AspectRatio(
        aspectRatio: 1 / 1.5,
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(10),
          ),
          child: bookImage,
        ),
      ),
    );

    return Scaffold(
        appBar: CustomAppBar(title: 'Detalhes do Livro', fromBottom: true),
        body: GestureDetector(
          onTap: hideKeyboard,
          child: SafeArea(
            bottom: false,
            child: Container(
              color: Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Center(
                      child: GestureDetector(
                        onTap: () async {
                          pickedImage = await _picker.pickImage(
                            source: ImageSource.gallery,
                            imageQuality: 25,
                          );

                          if (pickedImage == null) return;

                          setState(() {
                            bookImage = BookImage(pickedImage!.path);
                          });
                        },
                        child: Hero(
                          tag: 'avatar-${book?.id}',
                          flightShuttleBuilder: (flightContext,
                                  animation,
                                  flightDirection,
                                  fromHeroContext,
                                  toHeroContext) =>
                              Center(
                            child: bookImageWidget,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 120),
                            child: AspectRatio(
                              aspectRatio: 1 / 1.5,
                              child: Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(10),
                                ),
                                child: bookImage,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[300]!,
                          offset: const Offset(0.0, -1.0),
                          blurRadius: 10.0,
                        )
                      ],
                    ),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 90,
                              width: double.maxFinite,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              child: RatingBar(starsNumber, _changeRating),
                            ),
                            DefaultTextField(
                              hint: 'Nome do livro',
                              controller: store.nameController,
                              onChanged: store.onChangeField,
                            ),
                            Container(height: 12),
                            DefaultTextField(
                              hint: 'Autor',
                              controller: store.authorController,
                              onChanged: store.onChangeField,
                            ),
                            Container(height: 12),
                            DefaultTextField(
                              hint: 'Total de páginas',
                              controller: store.pagesController,
                              keyboardType: TextInputType.number,
                              onChanged: store.onChangeField,
                            ),
                            Container(height: 20),
                            Row(
                              children: [
                                Flexible(
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey[200],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        const Text(
                                          'Páginas lidas: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Flexible(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(
                                                width: 35,
                                                height: 35,
                                                child: GestureDetector(
                                                  onTapDown: (_) =>
                                                      _timerAction(_removeRead),
                                                  onTapUp: (_) =>
                                                      _timer.cancel(),
                                                  onTapCancel: _timer.cancel,
                                                  onTap: _removeRead,
                                                  child:
                                                      const Icon(Icons.remove),
                                                ),
                                              ),
                                              const SizedBox(width: 4),
                                              SizedBox(
                                                width: 50,
                                                child: TextField(
                                                  textAlign: TextAlign.center,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration:
                                                      const InputDecoration(
                                                    border: InputBorder.none,
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    enabledBorder:
                                                        InputBorder.none,
                                                    errorBorder:
                                                        InputBorder.none,
                                                    disabledBorder:
                                                        InputBorder.none,
                                                  ),
                                                  controller:
                                                      store.readPagesController,
                                                ),
                                              ),
                                              Container(width: 4),
                                              SizedBox(
                                                width: 35,
                                                height: 35,
                                                child: GestureDetector(
                                                    onTapDown: (_) =>
                                                        _timerAction(_addRead),
                                                    onTapUp: (_) =>
                                                        _timer.cancel(),
                                                    onTapCancel: _timer.cancel,
                                                    onTap: _addRead,
                                                    child:
                                                        const Icon(Icons.add)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(width: 12),
                                StreamBuilder<bool>(
                                    stream: store.enabledButton,
                                    builder: (context, snapshot) {
                                      return SizedBox(
                                        child: ElevatedButton(
                                          child: const Text('Salvar'),
                                          onPressed: snapshot.data ?? false
                                              ? () async {
                                                  await store.insertBook(
                                                    book?.id,
                                                    starsNumber,
                                                    pickedImage,
                                                    book?.imagePath,
                                                  );
                                                  Modular.to.pop(true);
                                                }
                                              : null,
                                          style: ElevatedButton.styleFrom(
                                            primary: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        ),
                                      );
                                    })
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
