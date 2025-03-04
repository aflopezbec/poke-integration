import 'package:injectable/injectable.dart';
import 'package:poke_detail/domain/model/Move.dart';
import 'package:poke_detail/domain/repository/pokemon_repository.dart';

@injectable
class GetMovesUseCase {
  PokemonRepository _pokemonRepository;

  GetMovesUseCase(this._pokemonRepository);

  Future<List<Move>> call(List<Move> moves) async {
    final response = await _pokemonRepository.getMoves(moves.map((m) => m.toDto()).toList());
    if (response.success) {
      return response.data?.map((e) => Move.fromDto(e)).toList() ?? [];
    } else {
      return [];
    }
  }
}
