import 'package:dartz/dartz.dart';
import 'package:marvel_app/app/helpers/error.dart';

import 'package:marvel_app/models/marvel.dart';

abstract class HeroesRepository {
  Future<Either<ApiError, List<MarvelCharacter>>> fetchMarvelHeroes({int offset});
}
