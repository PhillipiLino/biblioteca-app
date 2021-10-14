import 'package:biblioteca/features/data/models/google_book_model.dart';

class GoogleSearchModel {
  final String kind;
  final int totalItems;
  final List<GoogleBookModel> items;

  GoogleSearchModel({
    required this.kind,
    required this.totalItems,
    required this.items,
  });

  factory GoogleSearchModel.fromJson(Map<String, dynamic> json) {
    List<GoogleBookModel> items = [];
    if (json['items'] != null) {
      json['items'].forEach((v) {
        items.add(GoogleBookModel.fromJson(v));
      });
    }

    return GoogleSearchModel(
      kind: json['kind'],
      totalItems: json['totalItems'],
      items: items,
    );
  }

  Map<String, dynamic> toJson() => {
        'kind': kind,
        'totalItems': totalItems,
        'items': items.toString(),
      };
}
