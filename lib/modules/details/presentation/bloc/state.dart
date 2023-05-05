part of 'bloc.dart';

abstract class DetailsState extends Equatable {
  final Model model;
  const DetailsState(this.model);

  @override
  List<Object> get props => [model];
}

class DetailsInitial extends DetailsState {
  const DetailsInitial(Model model) : super(model);
}

class DetailsLoading extends DetailsState {
  const DetailsLoading(Model model) : super(model);
}

class DetailsLoaded extends DetailsState {
  const DetailsLoaded(Model model) : super(model);
}

class DetailsError extends DetailsState {
  const DetailsError(Model model) : super(model);
}

class Model extends Equatable {
  final List<Comic> comics;
  final List<Event> events;
  final List<Series> series;
  final List<Story> stories;

  const Model({
    this.comics = const [],
    this.events = const [],
    this.series = const [],
    this.stories = const [],
  });

  Model copyWith({
    List<Comic>? comics,
    List<Event>? events,
    List<Series>? series,
    List<Story>? stories,
  }) {
    return Model(
      comics: comics ?? this.comics,
      events: events ?? this.events,
      series: series ?? this.series,
      stories: stories ?? this.stories,
    );
  }

  @override
  List<Object?> get props => [
        comics,
        events,
        series,
        stories,
      ];
}
