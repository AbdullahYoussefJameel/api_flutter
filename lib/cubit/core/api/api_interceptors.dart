import 'package:api_flutter/cashe/cashe_helper.dart';
import 'package:api_flutter/cubit/core/api/end_ponits.dart';
import 'package:dio/dio.dart';

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers[ApiKey.token] =
        CacheHelper().getData(key: ApiKey.token) != null
        ? 'FODAPI ${CacheHelper().getData(key: ApiKey.token)}'
        : null;
    super.onRequest(options, handler);
  }
}
