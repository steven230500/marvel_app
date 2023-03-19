part of 'bloc.dart';

abstract class MarvelHeroesEvent extends Equatable {
  const MarvelHeroesEvent();

  @override
  List<Object> get props => [];
}

class GetDataHeroes extends MarvelHeroesEvent {}
