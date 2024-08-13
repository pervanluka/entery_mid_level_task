import 'package:cached_network_image/cached_network_image.dart';
import 'package:entery_mid_level_task/models/products/products_model.dart';
import 'package:entery_mid_level_task/shared/widgets/skeleton_animation.dart';
import 'package:entery_mid_level_task/shared/widgets/start_rating.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return SizedBox(
      height: 140,
      child: LayoutBuilder(builder: (context, constraints) {
        return Card(
          elevation: 20,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CachedNetworkImage(
                height: constraints.maxHeight,
                width: constraints.maxWidth * 0.4,
                fit: BoxFit.cover,
                imageUrl: product.thumbnail,
                placeholder: (context, url) => Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    shape: BoxShape.circle,
                  ),
                  child: SkeletonAnimation(
                    shimmerColor: Colors.grey.shade400,
                    child: const SizedBox.shrink(),
                  ),
                ),
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white.withOpacity(0.1)
                        : Colors.black.withOpacity(0.1),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      colorFilter: const ColorFilter.mode(
                        Colors.white12,
                        BlendMode.colorBurn,
                      ),
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                  ),
                ),
              ),
              const Gap(16),
              Padding(
                padding: const EdgeInsets.only(
                  right: 8,
                  top: 8,
                  bottom: 8,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: constraints.maxWidth * 0.45),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      FittedBox(
                        child: Text(
                          product.title,
                          style: theme.textTheme.titleMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      FittedBox(
                        child: StarRating(rating: product.rating),
                      ),
                      FittedBox(
                        child: Text(
                          '\$${product.price}',
                          style: theme.textTheme.titleSmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
