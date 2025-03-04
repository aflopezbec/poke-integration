import 'package:injectable/injectable.dart';
import 'package:poke_detail/domain/model/Ability.dart';
import 'package:poke_detail/domain/repository/pokemon_repository.dart';

@injectable
class GetAbilitiesUseCase {
  PokemonRepository _pokemonRepository;

  GetAbilitiesUseCase(this._pokemonRepository);

  Future<List<Ability>> call(List<Ability> abilities) async {
    final response = await _pokemonRepository.getAbilities(abilities.map((e) => e.toDto()).toList());
    if (response.success) {
      return response.data?.map((e) => Ability.fromDto(e)).toList() ?? [];
    } else {
      return [];
    }
  }
}
