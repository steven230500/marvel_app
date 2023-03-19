part of 'bloc.dart';

abstract class MarvelHeroesState extends Equatable {
  final Model model;
  const MarvelHeroesState(this.model);

  @override
  List<Object> get props => [model];
}

class MarvelHeroesInitial extends MarvelHeroesState {
  const MarvelHeroesInitial(Model model) : super(model);
}

class MarvelHeroesLoading extends MarvelHeroesState {
  const MarvelHeroesLoading(Model model) : super(model);
}

class MarvelHeroesLoaded extends MarvelHeroesState {
  const MarvelHeroesLoaded(Model model) : super(model);
}

class MarvelHeroesError extends MarvelHeroesState {
  const MarvelHeroesError(Model model) : super(model);
}

class Model extends Equatable {
  final List<MarvelCharacter> heroes;
  final int offset;

  const Model({
    this.heroes = const [],
    this.offset = 0,
  });

  Model copyWith({
    List<MarvelCharacter>? heroes,
    int? offset,
  }) {
    return Model(
      heroes: heroes ?? this.heroes,
      offset: offset ?? this.offset,
    );
  }

  @override
  List<Object?> get props => [
        heroes,
        offset,
      ];
}
