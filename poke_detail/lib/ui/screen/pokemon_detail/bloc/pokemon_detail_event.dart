part of 'pokemon_detail_bloc.dart';

abstract class PokemonDetailEvent extends Equatable {}

class SetPokemonEvent extends PokemonDetailEvent {
  final Pokemon pokemon;

  SetPokemonEvent(this.pokemon);

  @override
  List<Object> get props => [pokemon];
}

class BackPokemonDetailEvent extends PokemonDetailEvent {
  @override
  List<Object> get props => [];
}

class ValueReceivedEvent extends PokemonDetailEvent {
  final int value;

  ValueReceivedEvent(this.value);

  @override
  List<Object> get props => [value];
}
