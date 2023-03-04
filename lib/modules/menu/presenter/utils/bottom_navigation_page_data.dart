import 'package:equatable/equatable.dart';

import 'bottom_navigation_item.dart';

class BottomNavigationPageData extends Equatable {
  final BottomNavigationItem navigationItem;
  final dynamic childData;

  const BottomNavigationPageData(
    this.navigationItem,
    this.childData,
  );

  @override
  List<Object?> get props => [
        navigationItem,
        childData,
      ];
}
