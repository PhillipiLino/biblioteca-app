/// *** GENERATED FILE - ANY CHANGES WOULD BE OBSOLETE ON NEXT GENERATION *** ///

/// Helper to test coverage for all project files
// ignore_for_file: unused_import
import 'package:biblioteca/splash/presenter/pages/splash_page.dart';
import 'package:biblioteca/splash/stores/splash_page_store.dart';
import 'package:biblioteca/app/database/datasources/database_datasource_implementation.dart';
import 'package:biblioteca/app/database/datasources/books_datasource.dart';
import 'package:biblioteca/app/database/models/book_model.dart';
import 'package:biblioteca/app/database/books_database.dart';
import 'package:biblioteca/app/database/type_converters/date_time_converter.dart';
import 'package:biblioteca/app/database/book_dao.dart';
import 'package:biblioteca/app/utils/image_helper.dart';
import 'package:biblioteca/app/utils/preferences_manager.dart';
import 'package:biblioteca/app/utils/book_adapter.dart';
import 'package:biblioteca/app/utils/trackers_helper.dart';
import 'package:biblioteca/app/utils/event_controller.dart';
import 'package:biblioteca/app/utils/auth_store.dart';
import 'package:biblioteca/app/utils/routes/app_routes.dart';
import 'package:biblioteca/app/utils/routes/constants.dart';
import 'package:biblioteca/app/utils/login_callback.dart';
import 'package:biblioteca/app/data/repositories/books_repository_implementation.dart';
import 'package:biblioteca/app/domain/repositories/books_repository.dart';
import 'package:biblioteca/app/domain/errors/exceptions.dart';
import 'package:biblioteca/app/domain/errors/failures.dart';
import 'package:biblioteca/app/domain/usecases/create_book_usecase.dart';
import 'package:biblioteca/app/domain/usecases/get_books_usecase.dart';
import 'package:biblioteca/app/domain/usecases/delete_book_usecase.dart';
import 'package:biblioteca/app/domain/entities/user_auth.dart';
import 'package:biblioteca/app/client/client_interceptor.dart';
import 'package:biblioteca/firebase_options.dart';
import 'package:biblioteca/app_widget.dart';
import 'package:biblioteca/main.dart';
import 'package:biblioteca/app_module.dart';
import 'package:biblioteca/modules/search/search_module.dart';
import 'package:biblioteca/modules/search/presenter/pages/search_page.dart';
import 'package:biblioteca/modules/search/presenter/widgets/search_book_item.dart';
import 'package:biblioteca/modules/search/presenter/store/search_store.dart';
import 'package:biblioteca/modules/search/data/repositories/search_books_repository_implementation.dart';
import 'package:biblioteca/modules/search/domain/repositories/books_repository.dart';
import 'package:biblioteca/modules/search/domain/usecases/search_books_usecase.dart';
import 'package:biblioteca/modules/search/domain/entities/search_params.dart';
import 'package:biblioteca/modules/search/domain/entities/search_book_entity.dart';
import 'package:biblioteca/modules/profile/presenter/controllers/progress_store.dart';
import 'package:biblioteca/modules/profile/presenter/pages/progress_page.dart';
import 'package:biblioteca/modules/profile/data/datasources/database_datasource_implementation.dart';
import 'package:biblioteca/modules/profile/data/datasources/user_datasource.dart';
import 'package:biblioteca/modules/profile/data/repositories/user_repository_implementation.dart';
import 'package:biblioteca/modules/profile/data/models/user_progress_model.dart';
import 'package:biblioteca/modules/profile/domain/repositories/user_repository.dart';
import 'package:biblioteca/modules/profile/domain/usecases/get_progress_usecase.dart';
import 'package:biblioteca/modules/profile/domain/entities/user_progress_entity.dart';
import 'package:biblioteca/modules/profile/profile_module.dart';
import 'package:biblioteca/modules/menu/localizations/messages/messages_all.dart';
import 'package:biblioteca/modules/menu/localizations/messages/messages_pt.dart';
import 'package:biblioteca/modules/menu/localizations/messages/messages_en.dart';
import 'package:biblioteca/modules/menu/localizations/menu_localizations_delegate.dart';
import 'package:biblioteca/modules/menu/localizations/menu_localization.dart';
import 'package:biblioteca/modules/menu/presenter/stores/bottom_navigation_page_store.dart';
import 'package:biblioteca/modules/menu/presenter/utils/bottom_navigation_item.dart';
import 'package:biblioteca/modules/menu/presenter/utils/bottom_navigation_page_data.dart';
import 'package:biblioteca/modules/menu/presenter/pages/bottom_navigation_page.dart';
import 'package:biblioteca/modules/menu/menu_module.dart';

void main() {}
