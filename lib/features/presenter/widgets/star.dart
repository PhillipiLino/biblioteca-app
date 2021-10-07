import 'package:flutter/material.dart';

class Star extends StatelessWidget {
  final bool isSelected;
  final double size;

  const Star(
    this.isSelected, {
    this.size = 18,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? Colors.amber : Colors.grey[200];
    return Icon(Icons.star, color: color, size: size);
  }
}
