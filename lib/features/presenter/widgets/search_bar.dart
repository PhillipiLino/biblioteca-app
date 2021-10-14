import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final String hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClean;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;

  const SearchBar({
    this.hint = '',
    this.controller,
    this.onChanged,
    this.onClean,
    this.onEditingComplete,
    this.onSubmitted,
    Key? key,
  }) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    bool isDark = brightnessValue == Brightness.dark;

    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        filled: true,
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        hintText: widget.hint,
        fillColor: isDark ? Colors.grey[700] : Colors.grey[200],
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(25.7),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(25.7),
        ),
        suffixIcon: _controller.text.isEmpty
            ? null
            : InkWell(
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  _controller.text = '';
                  setState(() {});
                  widget.onClean?.call();
                  widget.onChanged?.call('');
                },
                child: const Icon(Icons.close_rounded),
              ),
      ),
      cursorRadius: const Radius.circular(10),
      cursorColor: Colors.grey,
      onChanged: (text) {
        widget.onChanged?.call(text);
        setState(() {});
      },
      onEditingComplete: widget.onEditingComplete,
      onSubmitted: widget.onSubmitted,
    );
  }
}
