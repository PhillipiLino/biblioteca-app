import 'package:biblioteca/features/domain/entities/book_entity.dart';
import 'package:biblioteca/features/presenter/widgets/star.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'book_image.dart';

class HomeBookItem extends StatelessWidget {
  final BookEntity book;
  final Function onTap;
  const HomeBookItem(
    this.book, {
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> stars = [];

    for (var i = 1; i <= 5; i++) {
      stars.add(Star(i <= book.stars));
    }

    final bookImageWidget = Container(
      height: 130,
      width: 90,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(10),
      ),
      child: BookImage(book.imagePath ?? ''),
    );

    return Material(
      child: InkWell(
        onTap: onTap as Function(),
        child: SizedBox(
          height: 150,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 130,
                width: 90,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Hero(
                  tag: 'avatar-${book.id}',
                  child: BookImage(book.imagePath ?? ''),
                  flightShuttleBuilder: (flightContext, animation,
                          flightDirection, fromHeroContext, toHeroContext) =>
                      Center(child: bookImageWidget),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.name,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                    Text(
                      book.author,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const SizedBox(height: 12),
                    Row(children: stars)
                  ],
                ),
              ),
              const SizedBox(width: 10),
              CircularPercentIndicator(
                startAngle: 0,
                radius: 60.0,
                lineWidth: 5.0,
                percent: book.progress,
                center: Text(book.percentage),
                progressColor: Theme.of(context).colorScheme.primary,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                animation: true,
                circularStrokeCap: CircularStrokeCap.round,
              )
            ],
          ),
        ),
      ),
    );
  }
}
