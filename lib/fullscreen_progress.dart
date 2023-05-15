import 'package:flutter/material.dart';

class FullscreenProgress extends StatelessWidget {
  const FullscreenProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      color: Colors.grey.withOpacity(0.5),
      child: const Center(
        child: CircularProgressIndicator(color: Colors.amber),
      ),
    );
  }
}
