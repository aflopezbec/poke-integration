import 'package:injectable/injectable.dart';
import 'package:poke_detail/core/network/api_response.dart';
import 'package:poke_detail/core/network/http_provider.dart';
import 'package:poke_detail/core/network/network_constants.dart';
import 'package:poke_detail/data/dto/ability_dto.dart';
import 'package:poke_detail/data/dto/move_dto.dart';
import 'package:poke_detail/data/dto/pokemon_dto.dart';
import 'package:poke_detail/domain/repository/pokemon_repository.dart';

@Injectable(as: PokemonRepository)
class PokemonRepositoryImpl implements PokemonRepository {
  final HttpProvider _httpProvider;

  PokemonRepositoryImpl(this._httpProvider);

  @override
  Future<ServerResponse<PokemonDto>> getPokemon(int id) async {
    try {
      final response = await _httpProvider.get("${NetworkConstants.pokemonSegment}/$id");
      final pokemonDto = PokemonDto.fromJson(response.data);
      return ServerResponse.success(pokemonDto);
    } on ServerResponse catch (e) {
      return ServerResponse.error(e.errorMessage ?? NetworkConstants.defaultError);
    } catch (e) {
      return ServerResponse.error(e.toString());
    }
  }

  @override
  Future<ServerResponse<List<AbilityDto>>> getAbilities(
    List<AbilityDto> abilities,
  ) async {
    try {
      final futures =
          abilities.where((ability) => ability.url != null).toList().map((ability) => _httpProvider.get(ability.url!));

      final responses = await Future.wait(futures);
      final abilityDtos = responses.map((response) => AbilityDto.fromJson(response.data)).toList();
      return ServerResponse.success(abilityDtos);
    } on ServerResponse catch (e) {
      return ServerResponse.error(e.errorMessage ?? NetworkConstants.defaultError);
    } catch (e) {
      return ServerResponse.error(e.toString());
    }
  }

  @override
  Future<ServerResponse<List<MoveDto>>> getMoves(
    List<MoveDto> moves,
  ) async {
    try {
      final futures = moves.where((move) => move.url != null).toList().map((move) => _httpProvider.get(move.url!));

      final responses = await Future.wait(futures);
      final movesDto = responses.map((response) => MoveDto.fromJson(response.data)).toList();
      return ServerResponse.success(movesDto);
    } on ServerResponse catch (e) {
      return ServerResponse.error(e.errorMessage ?? NetworkConstants.defaultError);
    } catch (e) {
      return ServerResponse.error(e.toString());
    }
  }
}
