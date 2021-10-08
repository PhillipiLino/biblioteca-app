import 'dart:io';

import 'package:flutter/material.dart';

class BookImage extends StatelessWidget {
  final String path;

  const BookImage(
    this.path, {
    Key? key,
  }) : super(key: key);

  Widget _errorBuilder(
    BuildContext context,
    Object exception,
    StackTrace? stackTrace,
  ) {
    return Container(
      color: Colors.grey[200],
      child: Center(
        child: Icon(
          Icons.menu_book_sharp,
          size: 60,
          color: Colors.grey[400],
        ),
      ),
    );
  }

  Widget _loadingBuilder(
    BuildContext context,
    Widget child,
    ImageChunkEvent? loadingProgress,
  ) {
    if (loadingProgress == null) return child;

    return Center(
      child: CircularProgressIndicator(
        value: loadingProgress.expectedTotalBytes != null
            ? loadingProgress.cumulativeBytesLoaded /
                loadingProgress.expectedTotalBytes!
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isUrlImage = path.contains('http://') || path.contains('https://');

    return isUrlImage
        ? Image.network(path,
            fit: BoxFit.cover, loadingBuilder: _loadingBuilder)
        : Image.file(File(path),
            fit: BoxFit.cover, errorBuilder: _errorBuilder);
  }
}
