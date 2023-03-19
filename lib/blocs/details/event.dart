part of 'bloc.dart';

abstract class DetailsEvent extends Equatable {
  const DetailsEvent();

  @override
  List<Object> get props => [];
}

class GetComics extends DetailsEvent {
  final int idCharacter;
  const GetComics(this.idCharacter);
}

class GetEvents extends DetailsEvent {
  final int idCharacter;
  const GetEvents(this.idCharacter);
}

class GetSeries extends DetailsEvent {
  final int idCharacter;
  const GetSeries(this.idCharacter);
}

class GetStories extends DetailsEvent {
  final int idCharacter;
  const GetStories(this.idCharacter);
}
