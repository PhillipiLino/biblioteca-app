import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  final String title;
  final bool fromBottom;

  CustomAppBar({
    required this.title,
    this.fromBottom = false,
    Key? key,
  })  : preferredSize = const Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      systemOverlayStyle:
          const SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
      title: Text(
        title,
        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      ),
      leading: (ModalRoute.of(context)?.canPop ?? false)
          ? IconButton(
              icon: Icon(
                (fromBottom
                    ? Icons.close_rounded
                    : Icons.arrow_back_ios_new_rounded),
              ),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      backgroundColor: Colors.transparent,
      foregroundColor: Theme.of(context).textTheme.button!.color,
      elevation: 0,
    );
  }
}
