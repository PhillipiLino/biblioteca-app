import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget? child;
  final VoidCallback? onPressed;
  final bool showShadow;
  final double? borderRadius;
  final Color? backgroundColor;

  const CustomCard({
    this.child,
    this.onPressed,
    this.showShadow = false,
    this.borderRadius,
    this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 12),
        boxShadow: [
          if (showShadow)
            BoxShadow(
              blurRadius: 4,
              color: Colors.grey.withOpacity(0.7),
            ),
        ],
      ),
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius ?? 8),
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
