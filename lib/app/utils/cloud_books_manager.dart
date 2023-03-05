import 'package:biblioteca/app/utils/auth_store.dart';
import 'package:biblioteca_books_module/biblioteca_books_module.dart';
import 'package:commons_tools_sdk/logger.dart';
import 'package:firebase_sdk/trackers.dart';

class CloudBooksManager {
  final AuthStore authStore;
  final FirebaseSDK firebase;

  CloudBooksManager(this.authStore, this.firebase);

  uploadBooks(List<BookEntity> books) async {
    final user = await authStore.getUser();
    if (user == null) return;

    final Map<String, Object> dict = {
      ...user.toJson(),
      'books': books.map((e) => e.toJson()).toList()
    };

    firebase.sendData(collectionName: 'user-books', path: user.uid, info: dict);
  }

  Future<List<BookEntity>?> downloadBooks() async {
    final user = await authStore.getUser();
    if (user == null) return null;

    try {
      final collection =
          await firebase.databaseAdapter.getCollection('user-books');
      final docRef = collection.doc(user.uid);
      final snapshot = await docRef.get();
      final data = snapshot.data() as Map<String, dynamic>?;

      return (data?['books'] as List?)
          ?.map((e) => BookEntity.fromJson(e))
          .toList();
    } catch (e) {
      LogManager.shared.logError('FIREBASE_SDK: $e');
    }
    return null;
  }
}
