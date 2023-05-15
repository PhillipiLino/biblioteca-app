import 'dart:async';

import 'package:flutter/material.dart';

class AppWidgetStore {
  final StreamController<bool> _fullAppLoaderController =
      StreamController<bool>();
  Stream<bool> get loaderStream => _fullAppLoaderController.stream;

  final StreamController<SnackMessage> _snackController =
      StreamController<SnackMessage>();
  Stream<SnackMessage> get snackStream => _snackController.stream;

  showSuccessMessage(String message) {
    _snackController.sink.add(SnackMessage(message, Colors.green));
  }

  showErrorMessage(String message) {
    _snackController.sink.add(SnackMessage(message, Colors.red));
  }

  showLoaderApp() {
    _fullAppLoaderController.sink.add(true);
  }

  hideLoaderApp() {
    _fullAppLoaderController.sink.add(false);
  }
}

class SnackMessage {
  final String message;
  final Color color;

  SnackMessage(this.message, this.color);
}
