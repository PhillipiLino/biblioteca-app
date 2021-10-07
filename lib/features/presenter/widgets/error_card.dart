import 'package:flutter/material.dart';

class ErrorCard extends StatelessWidget {
  final String message;
  final Function onTap;

  const ErrorCard(
    this.message,
    this.onTap, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message),
          ElevatedButton(
            onPressed: onTap as Function(),
            child: const Text('Tentar novamente'),
          )
        ],
      ),
    );
  }
}
