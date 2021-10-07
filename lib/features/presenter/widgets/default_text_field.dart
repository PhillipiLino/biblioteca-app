import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final TextAlign textAlign;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;

  const DefaultTextField({
    this.hint = '',
    this.controller,
    this.textAlign = TextAlign.start,
    this.keyboardType,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(fontSize: 15),
      textAlign: textAlign,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: true,
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[500]),
        fillColor: Colors.grey[200],
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(5),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      cursorRadius: const Radius.circular(10),
      cursorColor: Colors.grey,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmitted,
    );
  }
}
