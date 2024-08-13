import 'package:entery_mid_level_task/models/products/products_model.dart';
import 'package:entery_mid_level_task/service/failure/failure.dart';
import 'package:entery_mid_level_task/service/products/products_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final IProductsRepository _productsRepository;
  int currentPage = 1;
  final int itemsPerPage = 20;
  bool hasReachedMax = false;

  ProductsCubit({required IProductsRepository productsRepository})
      : _productsRepository = productsRepository,
        super(ProductsInitial());

  Future<void> getProducts({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;
      hasReachedMax = false;
    }

    final currentState = state;
    if (currentState is ProductsLoading || hasReachedMax) return;

    if (currentState is ProductsLoaded && !isRefresh) {
      emit(ProductsLoaded(
        data: currentState.data,
        hasReachedMax: currentState.hasReachedMax,
        isLoadingMore: true,
      ));
    } else {
      emit(
        const ProductsLoading(loadingType: LoadingType.loading),
      );
    }

    final result = await _productsRepository.getProducts(page: currentPage, limit: itemsPerPage);
    result.fold(
      (failure) => emit(ProductsFailure(failure)),
      (data) {
        final List<Product> currentData =
            currentState is ProductsLoaded ? currentState.data.products : [];
        final products = isRefresh ? data.products : currentData + data.products;

        hasReachedMax = data.products.length < itemsPerPage;
        emit(ProductsLoaded(
          data: data.copyWith(products: products),
          hasReachedMax: hasReachedMax,
        ));
        currentPage++;
      },
    );
  }
}
