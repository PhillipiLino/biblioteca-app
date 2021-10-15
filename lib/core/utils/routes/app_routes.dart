import 'package:biblioteca/core/utils/routes/constants.dart';
import 'package:biblioteca/modules/books/domain/entities/book_entity.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppRoutes {
  goToMenu(String page) => Modular.to.navigate(
        '$menuRoute$page/',
        arguments: page,
      );

  openDetails([BookEntity? book]) => Modular.to.pushNamed(
        '$menuRoute$booksRoute$detailsRoute',
        arguments: book,
      );
}
