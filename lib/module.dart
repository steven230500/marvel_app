import 'package:flutter_modular/flutter_modular.dart';
import 'package:marvel_app/app/config/config.dart';
import 'package:marvel_app/app/helpers/preferences.dart';
import 'package:marvel_app/app/http/client.dart';
import 'package:marvel_app/app/http/dio/dio.dart';
import 'package:marvel_app/modules/details/module.dart';
import 'package:marvel_app/modules/home/module.dart';
import 'package:marvel_app/modules/splash/module.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppModule extends Module {
  AppModule({
    required this.appConfig,
    required this.sharedPreferences,
  });

  final AppConfig appConfig;
  final SharedPreferences sharedPreferences;

  @override
  List<Bind> get binds {
    return [
      Bind<AppConfig>(
        (i) => appConfig,
      ),
      Bind<SharedPreferences>(
        (i) => sharedPreferences,
      ),
      Bind<MarvelHttp>(
        (i) => MarvelDioHttpClient(
          appConfig: appConfig,
          preferences: i<MarvelPreferences>(),
        ),
      ),
      Bind<MarvelPreferences>(
        (i) => MarvelPreferences(
          sharedPreferences: sharedPreferences,
        ),
      ),
    ];
  }

  @override
  List<ModularRoute> get routes {
    return [
      ModuleRoute(
        '/',
        module: SplashModule(),
      ),
      ModuleRoute(
        '/home',
        module: HomeModule(),
      ),
      ModuleRoute(
        '/detail',
        module: DetailModule(),
      ),
    ];
  }
}
