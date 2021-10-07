import 'package:clean_biblioteca/features/domain/entities/book_entity.dart';
import 'package:clean_biblioteca/features/presenter/widgets/star.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

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

    return Material(
      child: InkWell(
        onTap: onTap as Function(),
        child: SizedBox(
          height: 150,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 130,
                width: 90,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(10),
                ),
                child: Hero(
                  tag: 'avatar-${book.id}',
                  child: Image.network(
                      'https://m.media-amazon.com/images/I/51dH0OWndEL.jpg'), // Utility.imageFromBase64String(book.imageUrl),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(book.name, textAlign: TextAlign.start),
                  Text(
                    book.author,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 12),
                  Row(children: stars)
                ],
              ),
              CircularPercentIndicator(
                startAngle: 180,
                radius: 60.0,
                lineWidth: 5.0,
                percent: book.progress,
                center: Text(book.percentage),
                progressColor: Colors.deepPurple,
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
