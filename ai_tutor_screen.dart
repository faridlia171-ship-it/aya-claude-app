import 'package:logger/logger.dart';

class LoggerService {
  static final LoggerService _instance = LoggerService._internal();

  factory LoggerService() => _instance;

  LoggerService._internal();

  final _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 80,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  void debug(String message) => _logger.d(message);
  void info(String message) => _logger.i(message);
  void warning(String message) => _logger.w(message);
  void error(String message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.e(message, error: error, stackTrace: stackTrace);
  void verbose(String message) => _logger.v(message);
}
