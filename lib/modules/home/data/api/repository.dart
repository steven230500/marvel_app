import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:marvel_app/app/contants/strings.dart';
import 'package:marvel_app/app/helpers/error.dart';
import 'package:marvel_app/app/helpers/hash.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:marvel_app/models/marvel.dart';
import 'package:marvel_app/modules/home/domain/repository/repository.dart';

class HeroesRepositoryImp implements HeroesRepository {
  @override
  Future<Either<ApiError, List<MarvelCharacter>>> fetchMarvelHeroes({int offset = 0}) async {
    try {
      final timeStamp = DateTime.now().toString();
      const publicKey = Constants.publicKey;
      const privateKey = Constants.privateKey;
      final hash = generateMarvelHash(timeStamp, publicKey, privateKey);

      final response = await http.get(Uri.parse(
          'https://gateway.marvel.com:443/v1/public/characters?apikey=$publicKey&hash=$hash&ts=$timeStamp&offset=$offset'));

      if (response.statusCode == HttpStatus.ok) {
        final data = json.decode(response.body);
        final heroes = data['data']['results']
            .map<MarvelCharacter>((json) => MarvelCharacter.fromJson(json))
            .toList();
        return right(heroes);
      } else {
        return left(
          ApiError(
            message: 'Error al recuperar los personajes de Marvel',
            code: response.statusCode,
          ),
        );
      }
    } catch (e) {
      return left(
        ApiError(
          message: 'Error inesperado al recuperar los personajes de Marvel',
          code: -1,
        ),
      );
    }
  }
}
