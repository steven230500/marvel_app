import 'package:flutter_modular/flutter_modular.dart';
import 'package:marvel_app/modules/splash/presentation/bloc/bloc.dart';
import 'package:marvel_app/modules/splash/presentation/page/splash.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

class SplashModule extends Module {
  @override
  List<Bind> get binds {
    return [
      BlocBind.factory<SplashBloc>(
        (i) => SplashBloc(),
      ),
    ];
  }

  @override
  List<ModularRoute> get routes {
    return [
      ChildRoute(
        '/',
        child: (context, args) => const SplashScreen(),
      ),
    ];
  }
}
