import 'package:dio/dio.dart';

import '../../domain/services/auth_service.dart';
import '../di/injector.dart';
import '../utils/app_logger.dart';


class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await getIt<AuthService>().getToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}


class LoggingInterceptor extends Interceptor {
  final _log = getIt<AppLogger>();
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _log.e('HTTP ERROR', err);
    super.onError(err, handler);
  }
}


class RetryOnNetworkErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.type == DioExceptionType.connectionError || err.type == DioExceptionType.receiveTimeout) {
// Estrutura básica para retry (uma vez). Ajuste conforme necessário.
      try {
        final req = err.requestOptions;
        final dio = Dio();
        final response = await dio.fetch(req);
        return handler.resolve(response);
      } catch (_) {}
    }
    return handler.next(err);
  }
}