import 'package:flutter_modular/flutter_modular.dart';
import 'package:marvel_app/modules/home/presentation/page/home.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds {
    return [];
  }

  @override
  List<ModularRoute> get routes {
    return [
      ChildRoute(
        '/',
        child: (context, args) => const HomePage(),
      ),
    ];
  }
}
