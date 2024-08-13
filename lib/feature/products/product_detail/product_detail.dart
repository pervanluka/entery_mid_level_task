import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:entery_mid_level_task/models/products/products_model.dart';
import 'package:entery_mid_level_task/shared/widgets/start_rating.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProductDetailPage extends StatelessWidget {
  final String id;
  final Product product;

  const ProductDetailPage({
    super.key,
    required this.id,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          child: Text(
            product.title,
            style: theme.textTheme.headlineMedium,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider.builder(
              itemCount: product.images.length,
              itemBuilder: (context, index, realIndex) {
                return Container(
                  width: MediaQuery.sizeOf(context).width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: product.images[index],
                    fit: BoxFit.cover,
                  ),
                );
              },
              options: CarouselOptions(
                height: 250.0,
                enlargeCenterPage: true,
                autoPlay: false,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: false,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
              ),
            ),
            const Gap(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StarRating(
                  rating: product.rating,
                ),
                Text(
                  '\$${product.price}',
                  style: theme.textTheme.headlineSmall!.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                )
              ],
            ),
            const Gap(16),
            Text(
              product.description,
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Icon(
          Icons.shopping_bag_outlined,
        ),
        onPressed: () => (),
        // child: const Icon(
        //   Icons.shopping_bag_outlined,
        // ),
      ),
    );
  }
}
