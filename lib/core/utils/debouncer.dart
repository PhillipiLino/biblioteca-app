import 'dart:async';

import 'dart:ui';

import 'package:flutter_modular/flutter_modular.dart';

class Debouncer implements Disposable {
  final int milliseconds;
  late VoidCallback action;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  @override
  void dispose() {
    _timer?.cancel();
  }
}
