import 'package:logger/logger.dart' as lg;


class AppLogger {
  final lg.Logger _logger = lg.Logger();
  void d(dynamic message) => _logger.d(message);
  void e(dynamic message, [dynamic error, StackTrace? stack]) => _logger.e(message, error: error, stackTrace: stack);
}