import 'package:biblioteca_network_sdk/google_service.dart';
import 'package:equatable/equatable.dart';

class SearchParams extends Equatable {
  final String filter;
  final int page;
  final int pageSize;

  const SearchParams({
    required this.filter,
    required this.page,
    this.pageSize = 30,
  });

  GoogleSearchRequest toSDK() => GoogleSearchRequest(
        term: filter,
        startIndex: page ~/ pageSize,
        maxResults: pageSize,
      );

  @override
  List<Object?> get props => [
        filter,
        page,
        pageSize,
      ];
}
