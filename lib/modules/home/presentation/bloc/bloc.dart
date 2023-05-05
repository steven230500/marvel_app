import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/models/marvel.dart';
import 'package:marvel_app/modules/home/domain/repository/repository.dart';

part 'event.dart';
part 'state.dart';

class MarvelHeroesBloc extends Bloc<MarvelHeroesEvent, MarvelHeroesState> {
  final HeroesRepository _heroRepository;
  MarvelHeroesBloc(this._heroRepository) : super(const MarvelHeroesInitial(Model())) {
    on<GetDataHeroes>(_onGetDataHeroes);
  }

  void _onGetDataHeroes(
    GetDataHeroes event,
    Emitter<MarvelHeroesState> emit,
  ) async {
    emit(
      MarvelHeroesLoading(state.model),
    );
    final result = await _heroRepository.fetchMarvelHeroes(offset: state.model.offset);
    result.fold(
      (apiError) {
        emit(
          MarvelHeroesError(state.model),
        );
      },
      (heroes) {
        emit(
          MarvelHeroesLoaded(
            state.model.copyWith(
              heroes: heroes,
              offset: heroes.length + state.model.offset,
            ),
          ),
        );
      },
    );
  }
}
