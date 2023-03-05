import 'package:biblioteca_books_module/biblioteca_books_module.dart';
import 'package:clean_architecture_utils/events.dart';
import 'package:clean_architecture_utils/usecase.dart';

import '../domain/usecases/create_book_usecase.dart';
import '../domain/usecases/delete_book_usecase.dart';
import '../domain/usecases/get_books_usecase.dart';

class EventController {
  final EventBus _eventBus;
  final CreateBooksUsecase createBookUsecase;
  final GetBooksUsecase getBookUsecase;
  final DeleteBookUsecase deleteBookUsecase;

  EventController(
    this._eventBus,
    this.createBookUsecase,
    this.getBookUsecase,
    this.deleteBookUsecase,
  ) {
    _eventBus.on().listen((event) {
      if (event is EventInfo) _parseData(event);
    });
  }

  _parseData(EventInfo info) async {
    switch (info.name) {
      case BooksModuleEvents.getBooks:
        final result = await getBookUsecase(NoParams());
        result.fold((error) {}, (success) {
          _eventBus.fire(EventInfo(
            name: BooksModuleEvents.updateHomeBooks,
            data: success,
          ));
        });
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
      default:
    }
  }
}
