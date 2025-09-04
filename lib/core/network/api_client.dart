import 'package:dio/dio.dart';
import 'interceptors.dart';

class ApiClient {
  ApiClient({required this.baseUrl}) {
    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 10),
      contentType: 'application/json',
    ));


    dio.interceptors.addAll([
      AuthInterceptor(),
      LoggingInterceptor(),
      RetryOnNetworkErrorInterceptor(),
    ]);


// (Opcional — Pinning):
// dio.httpClientAdapter = IOHttpClientAdapter(
// createHttpClient: () {
// final client = HttpClient();
// // Exemplo de verificação manual do certificado (fingerprint pinning)
// client.badCertificateCallback = (cert, host, port) {
// // Comparar SHA-256 do certificado com sua lista pinada
// // final sha256 = base64Encode(cert.sha256);
// // return allowedFingerprints.contains(sha256);
// return false; // mantenha false em prod e implemente verificação real
// };
// return client;
// },
// );
  }


  final String baseUrl;
  late final Dio dio;
}