import 'package:biblioteca/features/presenter/widgets/star.dart';
import 'package:flutter/material.dart';

class RatingBar extends StatefulWidget {
  final int rating;
  final int quantity;
  final ValueChanged<int> onChangeValue;
  const RatingBar(
    this.rating,
    this.onChangeValue, {
    this.quantity = 5,
    Key? key,
  }) : super(key: key);

  @override
  _RatingBarState createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> with TickerProviderStateMixin {
  List<Animation<Offset>> animations = [];
  List<AnimationController> controllers = [];
  int animationDuration = 80;
  List<Widget> stars = [];
  int value = 0;

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < widget.quantity; i++) {
      final controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: animationDuration),
      );

      final animation = Tween<Offset>(
        begin: const Offset(0, 0),
        end: const Offset(0, -0.4),
      ).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOut),
      );

      controllers.add(controller);
      animations.add(animation);
    }

    value = widget.rating;
  }

  Widget createStar(int position) {
    return SlideTransition(
      position: animations[position - 1],
      child: Star(
        value >= position,
        onTap: () => _animateStars(position),
        size: 30,
      ),
    );
  }

  _animateStars(int selected) async {
    setState(() => value = selected);
    widget.onChangeValue(selected);
    for (var i = 0; i <= selected - 1; i++) {
      await Future.delayed(const Duration(milliseconds: 50), () {
        controllers[i].forward().whenComplete(() => controllers[i].reverse());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> stars = [];

    for (var i = 0; i < widget.quantity; i++) {
      stars.add(createStar(i + 1));
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: stars,
    );
  }
}
