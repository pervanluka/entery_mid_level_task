import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class StarRating extends StatelessWidget {
  final double rating;
  final double starSize;
  final Color filledColor;
  final Color unfilledColor;

  const StarRating({
    Key? key,
    required this.rating, // Rating value from 0.0 to 5.0
    this.starSize = 16.0, // Size of each star
    this.filledColor = Colors.amber, // Color of filled stars
    this.unfilledColor = Colors.grey, // Color of unfilled stars
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(5, (index) {
            // Calculate the fill of each star
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
