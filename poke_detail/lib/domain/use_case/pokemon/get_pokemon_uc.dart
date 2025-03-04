import 'package:injectable/injectable.dart';
import 'package:poke_detail/domain/model/pokemon.dart';
import 'package:poke_detail/domain/repository/pokemon_repository.dart';

@injectable
class GetPokemonUseCase {
  final PokemonRepository pokemonRepository;

  GetPokemonUseCase(this.pokemonRepository);

  Future<Pokemon?> call(int id) async {
    final response = await pokemonRepository.getPokemon(id);

    if (response.success) {
      final pokemonDto = response.data;
      if (pokemonDto == null) return null;
      return Pokemon.fromDto(pokemonDto);
    } else {
      return null;
    }
  }
}
