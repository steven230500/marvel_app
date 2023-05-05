import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/models/comics.dart';
import 'package:marvel_app/models/events.dart';
import 'package:marvel_app/models/series.dart';
import 'package:marvel_app/models/stories.dart';
import 'package:marvel_app/modules/details/domain/repository/repository.dart';

part 'event.dart';
part 'state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final HeroesDetailRepository _heroRepository;

  DetailsBloc(this._heroRepository) : super(const DetailsInitial(Model())) {
    on<GetComics>(_onGetComics);
    on<GetEvents>(_onGetEvents);
    on<GetSeries>(_onGetSeries);
    on<GetStories>(_onGetStories);
  }
  void _onGetComics(
    GetComics event,
    Emitter<DetailsState> emit,
  ) async {
    emit(
      DetailsLoading(state.model),
    );

    final result = await _heroRepository.fetchCharacterComics(event.idCharacter);
    result.fold(
      (apiError) {
        emit(
          DetailsError(state.model),
        );
      },
      (comics) {
        emit(
          DetailsLoaded(
            state.model.copyWith(
              comics: comics,
            ),
          ),
        );
      },
    );
  }

  void _onGetEvents(
    GetEvents event,
    Emitter<DetailsState> emit,
  ) async {
    emit(
      DetailsLoading(state.model),
    );
    final result = await _heroRepository.fetchCharacterEvents(event.idCharacter);
    result.fold(
      (apiError) {
        emit(
          DetailsError(state.model),
        );
      },
      (events) {
        emit(
          DetailsLoaded(
            state.model.copyWith(
              events: events,
            ),
          ),
        );
      },
    );
  }

  void _onGetStories(
    GetStories event,
    Emitter<DetailsState> emit,
  ) async {
    emit(
      DetailsLoading(state.model),
    );
    final result = await _heroRepository.fetchCharacterStories(event.idCharacter);
    result.fold(
      (apiError) {
        emit(
          DetailsError(state.model),
        );
      },
      (stories) {
        emit(
          DetailsLoaded(
            state.model.copyWith(
              stories: stories,
            ),
          ),
        );
      },
    );
  }

  void _onGetSeries(
    GetSeries event,
    Emitter<DetailsState> emit,
  ) async {
    emit(
      DetailsLoading(state.model),
    );
    final result = await _heroRepository.fetchCharacterSeries(event.idCharacter);
    result.fold(
      (apiError) {
        emit(
          DetailsError(state.model),
        );
      },
      (series) {
        emit(
          DetailsLoaded(
            state.model.copyWith(
              series: series,
            ),
          ),
        );
      },
    );
  }
}
