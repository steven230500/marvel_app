import 'package:flutter_modular/flutter_modular.dart';
import 'package:marvel_app/app/http/client.dart';
import 'package:marvel_app/modules/details/data/api/repository.dart';
import 'package:marvel_app/modules/details/domain/repository/repository.dart';
import 'package:marvel_app/modules/details/presentation/bloc/bloc.dart';
import 'package:marvel_app/modules/details/presentation/page/detail.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

class DetailModule extends Module {
  @override
  List<Bind> get binds {
    return [
      BlocBind.factory(
        (i) => DetailsBloc(
          i<HeroesDetailRepository>(),
        ),
      ),
      Bind<HeroesDetailRepository>(
        (i) => HeroesDetailRepositoryImpl(
          marvelHttp: i<MarvelHttp>(),
        ),
      )
    ];
  }

  @override
  List<ModularRoute> get routes {
    return [
      ChildRoute(
        '/',
        child: (context, args) => DetailScreen(characterId: args.data['characterId']),
      ),
    ];
  }
}
