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
      child: Image.asset(
        'assets/images/book_placeholder.png',
        fit: BoxFit.cover,
        filterQuality: FilterQuality.medium,
      ),
    );
  }

  Widget _loadingBuilder(
    BuildContext context,
    Widget child,
    ImageChunkEvent? loadingProgress,
  ) {
    if (loadingProgress == null) return child;

    return Container(
      color: Theme.of(context).colorScheme.secondary,
      width: double.infinity,
      child: Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.primary,
          strokeWidth: 1.5,
        ),
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
