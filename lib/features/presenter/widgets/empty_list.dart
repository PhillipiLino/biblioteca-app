import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  final Function onTap;
  const EmptyList(
    this.onTap, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Lista vazia. Adicione um livro'),
          ElevatedButton(
            onPressed: onTap as Function(),
            child: const Text('Adicionar'),
            style: ElevatedButton.styleFrom(
                primary: Theme.of(context).colorScheme.secondary),
          )
        ],
      ),
    );
  }
}
