part of 'pokemon_detail_bloc.dart';

class PokemonDetailState extends Equatable {
  final bool isLoading;
  final Pokemon? pokemon;
  final int id;

  const PokemonDetailState({
    this.isLoading = true,
    this.pokemon,
    this.id = 0,
  });

  PokemonDetailState copyWith({
    bool? isLoading,
    ValueGetter<Pokemon?>? pokemon,
    int? id,
  }) {
    return PokemonDetailState(
      isLoading: isLoading ?? this.isLoading,
      pokemon: pokemon != null ? pokemon() : this.pokemon,
      id: id ?? this.id,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        pokemon,
        id,
      ];
}
