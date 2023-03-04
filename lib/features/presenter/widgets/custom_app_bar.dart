import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

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
      toolbarHeight: 20,
      systemOverlayStyle:
          const SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
      title: Text(
        title,
        style: GoogleFonts.raleway(
          textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
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
      foregroundColor: Colors.white,
      elevation: 0,
    );
  }
}
