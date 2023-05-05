import 'package:dartz/dartz.dart';
import 'package:marvel_app/app/helpers/error.dart';
import 'package:marvel_app/models/comics.dart';
import 'package:marvel_app/models/events.dart';

import 'package:marvel_app/models/series.dart';
import 'package:marvel_app/models/stories.dart';

abstract class HeroesDetailRepository {
  Future<Either<ApiError, List<Comic>>> fetchCharacterComics(int characterId);
  Future<Either<ApiError, List<Event>>> fetchCharacterEvents(int characterId);
  Future<Either<ApiError, List<Series>>> fetchCharacterSeries(int characterId);
  Future<Either<ApiError, List<Story>>> fetchCharacterStories(int characterId);
}
