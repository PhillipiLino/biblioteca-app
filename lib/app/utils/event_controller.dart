import 'package:biblioteca/app/domain/usecases/update_books_usecase.dart';
import 'package:biblioteca/app/utils/book_adapter.dart';
import 'package:biblioteca/app/utils/routes/constants.dart';
import 'package:biblioteca/app_widget_store.dart';
import 'package:biblioteca_books_module/biblioteca_books_module.dart';
import 'package:biblioteca_search_module/biblioteca_search_module.dart';
import 'package:clean_architecture_utils/events.dart';
import 'package:clean_architecture_utils/usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../domain/usecases/create_book_usecase.dart';
import '../domain/usecases/delete_book_usecase.dart';
import '../domain/usecases/get_books_usecase.dart';
import 'cloud_books_manager.dart';

class EventController {
  final EventBus _eventBus;
  final CreateBooksUsecase createBookUsecase;
  final GetBooksUsecase getBookUsecase;
  final DeleteBookUsecase deleteBookUsecase;
  final UpdateBooksUsecase updateBooksUsecase;
  final CloudBooksManager cloudManager;
  final AppWidgetStore appStore;

  EventController(
    this._eventBus,
    this.createBookUsecase,
    this.getBookUsecase,
    this.deleteBookUsecase,
    this.updateBooksUsecase,
    this.cloudManager,
    this.appStore,
  ) {
    _eventBus.on().listen((event) {
      if (event is EventInfo) _parseData(event);
    });
  }

  _parseData(EventInfo info) async {
    switch (info.name) {
      case DefaultEvents.showSuccessMessageEvent:
        appStore.showSuccessMessage(info.data);
        break;
      case DefaultEvents.showErrorMessageEvent:
        appStore.showErrorMessage(info.data);
        break;
      case DefaultEvents.showAppLoaderEvent:
        appStore.showLoaderApp();
        break;
      case DefaultEvents.hideAppLoaderEvent:
        appStore.hideLoaderApp();
        break;
      case BooksModuleEvents.getBooks:
        updateHomeBooks();
        break;
      case BooksModuleEvents.saveBook:
        final data = info.data as BookToSaveEntity?;
        if (data == null) return;

        final result = await createBookUsecase(data);
        result.fold((error) {}, (success) {
          _eventBus.fire(
            const EventInfo(name: BooksModuleEvents.bookSavedSuccess),
          );
        });

        break;
      case BooksModuleEvents.deleteBook:
        final data = info.data as BookEntity?;
        if (data == null) return;

        final result = await deleteBookUsecase(data);
        result.fold((error) {}, (success) {
          _eventBus.fire(const EventInfo(
            name: BooksModuleEvents.bookDeletedSuccess,
          ));
        });

        break;
      case BooksModuleEvents.uploadBooks:
        final data = info.data as List<BookEntity>? ?? [];
        if (data.isEmpty) return;
        appStore.showLoaderApp();
        await cloudManager.uploadBooks(data);
        appStore.hideLoaderApp();

        break;
      case BooksModuleEvents.downloadBooks:
        appStore.showLoaderApp();

        final books = await cloudManager.downloadBooks() ?? [];
        if (books.isEmpty) {
          appStore.hideLoaderApp();
          return;
        }

        await updateBooksUsecase(books);
        appStore.hideLoaderApp();
        updateHomeBooks();

        break;
      case SearchModuleEvents.searchOpenDetails:
        final data = info.data as SearchBookEntity?;
        if (data == null) return;

        Modular.to.pushNamed(
          '$booksRoute$detailsRoute',
          arguments: data.toDetails(),
        );
        break;
      default:
    }
  }

  updateHomeBooks() async {
    final result = await getBookUsecase(NoParams());
    result.fold((error) {}, (success) {
      _eventBus.fire(EventInfo(
        name: BooksModuleEvents.updateHomeBooks,
        data: success,
      ));
    });
  }
}
