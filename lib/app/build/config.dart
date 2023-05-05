import 'package:logger/logger.dart';
import 'package:marvel_app/app/config/config.dart';
import 'package:marvel_app/app/contants/strings.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppBuildData {
  const AppBuildData._();

  static Future<AppConfig> config() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    const appEnv = bool.fromEnvironment('dart.vm.product') ? AppEnv.prod : AppEnv.test;

    String baseUrl = '';

    if (appEnv == AppEnv.prod) {
      baseUrl = Constants.baseUrlProd;
    } else {
      baseUrl = Constants.baseUrlDev;
    }

    return AppConfig(
      appName: packageInfo.appName,
      appVersion: packageInfo.version,
      baseUrl: baseUrl,
      env: appEnv,
      log: Logger(
        printer: PrettyPrinter(
          methodCount: 0,
          errorMethodCount: 8,
          lineLength: 120,
          colors: true,
          printEmojis: true,
          printTime: true,
        ),
      ),
    );
  }
}
