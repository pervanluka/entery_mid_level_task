import 'package:dartz/dartz.dart';
import 'package:entery_mid_level_task/models/products/products_model.dart';
import 'package:entery_mid_level_task/service/failure/failure.dart';
import 'package:entery_mid_level_task/service/web_api_base_service.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

abstract interface class IProductsRepository {
  Future<Either<Failure, Products>> getProducts({required int page, required int limit});
}

class ProductWebApiService extends WebApiServiceBase implements IProductsRepository {
  ProductWebApiService(super.dioClient);
  final logger = Logger();

  @override
  @override
  Future<Either<Failure, Products>> getProducts({required int page, required int limit}) async {
    final skip = (page - 1) * limit;
    final path = 'products?skip=$skip&limit=$limit';

    logger.log(Level.info, 'Requesting products with URL: $path');

    final response = await dioRequest(
      url: path,
      method: 'GET',
    );

    return await response.fold(
      (fail) {
        logger.log(Level.error, fail.description);
        return Left(fail);
      },
      (data) async {
        try {
          final products = await compute<Map<String, dynamic>, Products>(
            (data) => Products.fromJson(data),
            data.data,
          );
          return Right(products);
        } catch (e, stacktrace) {
          logger.log(Level.error, 'Compute function failed: $e');
          logger.log(Level.error, stacktrace.toString());
          return Left(
            Failure.unknownServerError('Failed to parse products data'),
          );
        }
      },
    );
  }
}
