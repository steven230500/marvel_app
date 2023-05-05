import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

class GuardInterceptor extends Interceptor {
  GuardInterceptor() : super();

  @override
  void onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) {
    if (Modular.args.uri.toString() == '/auth/login/') {
      return super.onError(err, handler);
    }

    if (err.response != null && err.response!.statusCode == 401) {
      Modular.to.pushNamedAndRemoveUntil('/', (p0) => false);
    }
    return super.onError(err, handler);
  }
}
