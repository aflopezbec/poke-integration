import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:poke_detail/core/network/api_response.dart';
import 'package:poke_detail/data/dto/pokemon_dto.dart';
import 'package:poke_detail/domain/model/pokemon.dart';
import 'package:poke_detail/domain/repository/pokemon_repository.dart';
import 'package:poke_detail/domain/use_case/pokemon/get_pokemon_uc.dart';

import 'get_pokemon_use_case_test.mocks.dart';

@GenerateMocks([PokemonRepository])
void main() {
  late GetPokemonUseCase getPokemonUseCase;
  late MockPokemonRepository mockPokemonRepository;

  setUp(() {
    mockPokemonRepository = MockPokemonRepository();
    getPokemonUseCase = GetPokemonUseCase(mockPokemonRepository);
  });

  const int testPokemonId = 1;
  const pokemonDto = PokemonDto(
    id: testPokemonId,
    name: "bulbasaur",
    image: "https://pokeapi.co/media/sprites/bulbasaur.png",
    imageHD: "https://pokeapi.co/media/sprites/generation-v/black-white/animated/bulbasaur.gif",
    abilities: [],
    moves: [],
  );

  final expectedPokemon = Pokemon.fromDto(pokemonDto);

  test('return pokemon when the response is success', () async {
    when(mockPokemonRepository.getPokemon(testPokemonId)).thenAnswer((_) async => ServerResponse.success(pokemonDto));

    final result = await getPokemonUseCase(testPokemonId);

    expect(result, equals(expectedPokemon));
    verify(mockPokemonRepository.getPokemon(testPokemonId)).called(1);
    verifyNoMoreInteractions(mockPokemonRepository);
  });

  test('return null when the response is an error', () async {
    when(mockPokemonRepository.getPokemon(testPokemonId)).thenAnswer((_) async => ServerResponse.error("Error"));

    final result = await getPokemonUseCase(testPokemonId);

    expect(result, isNull);
    verify(mockPokemonRepository.getPokemon(testPokemonId)).called(1);
    verifyNoMoreInteractions(mockPokemonRepository);
  });
}
