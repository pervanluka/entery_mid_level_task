part of 'products_cubit.dart';

enum LoadingType {
  loading,
  loadingMore,
}

sealed class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final Products data;
  final bool hasReachedMax;
  final bool isLoadingMore;

  const ProductsLoaded({
    required this.data,
    this.hasReachedMax = false,
    this.isLoadingMore = false,
  });

  @override
  List<Object> get props => [data, hasReachedMax, isLoadingMore];
}

class ProductsFailure extends ProductsState {
  final Failure failure;

  const ProductsFailure(this.failure);

  @override
  List<Object> get props => [failure];
}
