import 'package:poke_detail/core/network/api_response.dart';
import 'package:poke_detail/data/dto/ability_dto.dart';
import 'package:poke_detail/data/dto/move_dto.dart';
import 'package:poke_detail/data/dto/pokemon_dto.dart';

abstract class PokemonRepository {
  Future<ServerResponse<PokemonDto>> getPokemon(int id);
  Future<ServerResponse<List<AbilityDto>>> getAbilities(List<AbilityDto> abilities);
  Future<ServerResponse<List<MoveDto>>> getMoves(List<MoveDto> moves);
}
