import 'package:biblioteca/app/domain/usecases/update_books_usecase.dart';
import 'package:biblioteca_books_module/biblioteca_books_module.dart';
import 'package:clean_architecture_utils/events.dart';
import 'package:clean_architecture_utils/usecase.dart';

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

  EventController(
    this._eventBus,
    this.createBookUsecase,
    this.getBookUsecase,
    this.deleteBookUsecase,
    this.updateBooksUsecase,
    this.cloudManager,
  ) {
    _eventBus.on().listen((event) {
      if (event is EventInfo) _parseData(event);
    });
  }

  _parseData(EventInfo info) async {
    switch (info.name) {
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
        cloudManager.uploadBooks(data);

        break;
      case BooksModuleEvents.downloadBooks:
        final books = await cloudManager.downloadBooks() ?? [];
        if (books.isEmpty) return;
        await updateBooksUsecase(books);
        updateHomeBooks();

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
