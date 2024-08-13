import 'dart:async';
import 'package:entery_mid_level_task/feature/products/cubit/products_cubit.dart';
import 'package:entery_mid_level_task/shared/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final ScrollController _scrollController = ScrollController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<ProductsCubit>().getProducts();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 300), () {
        context.read<ProductsCubit>().getProducts();
      });
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.atEdge;
    final currentScroll = _scrollController.position.pixels;
    return maxScroll && currentScroll != 0;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: BlocConsumer<ProductsCubit, ProductsState>(
        listener: (context, state) {
          if (state is ProductsInitial) {
            context.read<ProductsCubit>().getProducts();
          }
        },
        builder: (context, state) {
          return switch (state) {
            ProductsInitial() => Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100, 48),
                    textStyle: theme.textTheme.bodyLarge,
                  ),
                  onPressed: () => context.read<ProductsCubit>().getProducts(),
                  child: const Text('Fetch'),
                ),
              ),
            ProductsFailure() => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Fetch failed! Try again.',
                      style: theme.textTheme.bodyLarge,
                    ),
                    const Gap(8),
                    ElevatedButton(
                      onPressed: () => context.read<ProductsCubit>().getProducts(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ProductsLoaded() => ListView.separated(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: state.hasReachedMax
                    ? state.data.products.length
                    : state.data.products.length + 1,
                itemBuilder: (context, index) {
                  if (index >= state.data.products.length) {
                    if (state.isLoadingMore) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    } else {
                      return const Gap(30);
                    }
                  }
                  return ProductCard(
                    product: state.data.products[index],
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                  height: 1,
                  color: Colors.transparent,
                ),
              ),
            ProductsLoading() => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
          };
        },
      ),
    );
  }
}
