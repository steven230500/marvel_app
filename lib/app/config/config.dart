import 'package:logger/logger.dart';

class AppConfig {
  const AppConfig({
    required this.appName,
    required this.appVersion,
    required this.baseUrl,
    required this.env,
    required this.log,
  });

  final String baseUrl;
  final String appName;
  final String appVersion;
  final AppEnv env;
  final Logger log;
}

enum AppEnv { prod, test }
