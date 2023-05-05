import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:marvel_app/app/contants/strings.dart';
import 'package:marvel_app/app/helpers/error.dart';
import 'package:marvel_app/app/helpers/hash.dart';
import 'package:http/http.dart' as http;
import 'package:marvel_app/app/http/client.dart';
import 'package:marvel_app/models/comics.dart';
import 'package:marvel_app/models/events.dart';
import 'dart:convert';

import 'package:marvel_app/models/series.dart';
import 'package:marvel_app/models/stories.dart';
import 'package:marvel_app/modules/details/domain/repository/repository.dart';

class HeroesDetailRepositoryImpl implements HeroesDetailRepository {
  HeroesDetailRepositoryImpl({
    required MarvelHttp marvelHttp,
  }) : _marvelHttp = marvelHttp;

  final MarvelHttp _marvelHttp;
  @override
  Future<Either<ApiError, List<Comic>>> fetchCharacterComics(int characterId) async {
    try {
      final timeStamp = DateTime.now().toString();
      const publicKey = Constants.publicKey;
      const privateKey = Constants.privateKey;
      final hash = generateMarvelHash(timeStamp, publicKey, privateKey);

      final response = await http.get(Uri.parse(
          'https://gateway.marvel.com:443/v1/public/characters/$characterId/comics?apikey=$publicKey&hash=$hash&ts=$timeStamp'));

      if (response.statusCode == HttpStatus.ok) {
        final data = json.decode(response.body);
        final comics = data['data']['results'].map<Comic>((json) => Comic.fromJson(json)).toList();
        return right(comics);
      } else {
        return left(
          ApiError(
            message: 'Error al recuperar los cómics del personaje',
            code: response.statusCode,
          ),
        );
      }
    } catch (e) {
      return left(
        ApiError(
          message: 'Error inesperado al recuperar los cómics del personaje',
          code: -1,
        ),
      );
    }
  }

  @override
  Future<Either<ApiError, List<Event>>> fetchCharacterEvents(int characterId) async {
    try {
      final timeStamp = DateTime.now().toString();
      const publicKey = Constants.publicKey;
      const privateKey = Constants.privateKey;
      final hash = generateMarvelHash(timeStamp, publicKey, privateKey);

      final response = await http.get(Uri.parse(
          'https://gateway.marvel.com:443/v1/public/characters/$characterId/events?apikey=$publicKey&hash=$hash&ts=$timeStamp'));

      if (response.statusCode == HttpStatus.ok) {
        final data = json.decode(response.body);
        final events = data['data']['results'].map<Event>((json) => Event.fromJson(json)).toList();
        return right(events);
      } else {
        return left(
          ApiError(
            message: 'Error al recuperar los eventos del personaje',
            code: response.statusCode,
          ),
        );
      }
    } catch (e) {
      return left(
        ApiError(
          message: 'Error inesperado al recuperar los eventos del personaje',
          code: -1,
        ),
      );
    }
  }

  @override
  Future<Either<ApiError, List<Series>>> fetchCharacterSeries(int characterId) async {
    try {
      final timeStamp = DateTime.now().toString();
      const publicKey = Constants.publicKey;
      const privateKey = Constants.privateKey;
      final hash = generateMarvelHash(timeStamp, publicKey, privateKey);

      final response = await http.get(Uri.parse(
          'https://gateway.marvel.com:443/v1/public/characters/$characterId/series?apikey=$publicKey&hash=$hash&ts=$timeStamp'));

      if (response.statusCode == HttpStatus.ok) {
        final data = json.decode(response.body);
        final series =
            data['data']['results'].map<Series>((json) => Series.fromJson(json)).toList();
        return right(series);
      } else {
        return left(
          ApiError(
            message: 'Error al recuperar las series del personaje',
            code: response.statusCode,
          ),
        );
      }
    } catch (e) {
      return left(
        ApiError(
          message: 'Error inesperado al recuperar las series del personaje',
          code: -1,
        ),
      );
    }
  }

  @override
  Future<Either<ApiError, List<Story>>> fetchCharacterStories(int characterId) async {
    try {
      final timeStamp = DateTime.now().toString();
      const publicKey = Constants.publicKey;
      const privateKey = Constants.privateKey;
      final hash = generateMarvelHash(timeStamp, publicKey, privateKey);

      final response = await http.get(Uri.parse(
          'https://gateway.marvel.com:443/v1/public/characters/$characterId/stories?apikey=$publicKey&hash=$hash&ts=$timeStamp'));

      if (response.statusCode == HttpStatus.ok) {
        final data = json.decode(response.body);
        final stories = data['data']['results'].map<Story>((json) => Story.fromJson(json)).toList();
        return right(stories);
      } else {
        return left(
          ApiError(
            message: 'Error al recuperar las historias del personaje',
            code: response.statusCode,
          ),
        );
      }
    } catch (e) {
      return left(
        ApiError(
          message: 'Error inesperado al recuperar las historias del personaje',
          code: -1,
        ),
      );
    }
  }
}
