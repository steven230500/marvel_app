import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/blocs/marvel_heroes/bloc.dart';
import 'package:marvel_app/helpers/error.dart';
import 'package:marvel_app/models/marvel.dart';
import 'package:marvel_app/repositories/heroes.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'marvel_heroes_bloc_test.mocks.dart';

@GenerateMocks([HeroesRepository])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late HeroesRepository heroesRepository;
  late MarvelHeroesBloc marvelHeroesBloc;

  final testHeroes = [
    MarvelCharacter(
      id: 1,
      name: 'Spider-Man',
      description: 'Friendly neighborhood Spider-Man',
      thumbnail: Thumbnail(
          path: 'http://i.annihil.us/u/prod/marvel/', extension: '.jpg'),
      urls: [],
    ),
    MarvelCharacter(
      id: 2,
      name: 'Iron Man',
      description: 'Genius. Billionaire. Playboy. Philanthropist.',
      thumbnail: Thumbnail(
          path: 'http://i.annihil.us/u/prod/marvel/', extension: '.jpg'),
      urls: [],
    ),
  ];

  final apiError = ApiError(
    message: 'Test Error',
    code: 500,
  );

  group('MarvelHeroesBloc', () {
    blocTest<MarvelHeroesBloc, MarvelHeroesState>(
      'emits [loading, loaded] when GetDataHeroes is added',
      build: () {
        heroesRepository = MockHeroesRepository(); // Utiliza el mock generado
        when(heroesRepository.fetchMarvelHeroes(offset: 0)).thenAnswer(
          (invocation) async =>
              Right<ApiError, List<MarvelCharacter>>(testHeroes),
        );
        marvelHeroesBloc = MarvelHeroesBloc(heroesRepository);
        return marvelHeroesBloc;
      },
      act: (bloc) => bloc.add(GetDataHeroes()),
      expect: () => [
        const MarvelHeroesLoading(Model()),
        MarvelHeroesLoaded(
          Model(
            heroes: testHeroes,
            offset: testHeroes.length,
          ),
        ),
      ],
    );

    blocTest<MarvelHeroesBloc, MarvelHeroesState>(
      'emits [loading, error] when a server error occurs',
      build: () {
        heroesRepository = MockHeroesRepository(); // Utiliza el mock generado
        when(heroesRepository.fetchMarvelHeroes(offset: 0)).thenAnswer(
          (invocation) async => Left<ApiError, List<MarvelCharacter>>(apiError),
        );
        marvelHeroesBloc = MarvelHeroesBloc(heroesRepository);
        return marvelHeroesBloc;
      },
      act: (bloc) => bloc.add(GetDataHeroes()),
      expect: () => [
        const MarvelHeroesLoading(Model()),
        const MarvelHeroesError(Model()),
      ],
    );
  });
}
