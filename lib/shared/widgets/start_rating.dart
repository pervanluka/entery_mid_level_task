import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class StarRating extends StatelessWidget {
  final double rating;
  final double starSize;
  final Color filledColor;
  final Color unfilledColor;

  const StarRating({
    Key? key,
    required this.rating,
    this.starSize = 16.0,
    this.filledColor = Colors.amber,
    this.unfilledColor = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(5, (index) {
            double fillAmount = (rating - index).clamp(0.0, 1.0);
            return Icon(
              Icons.star,
              size: starSize,
              color: fillAmount == 1.0
                  ? filledColor
                  : fillAmount > 0.0
                      ? filledColor.withOpacity(fillAmount)
                      : unfilledColor,
            );
          }),
        ),
        const Gap(4),
        Text(
          rating.toStringAsFixed(1),
        ),
      ],
    );
  }
}
