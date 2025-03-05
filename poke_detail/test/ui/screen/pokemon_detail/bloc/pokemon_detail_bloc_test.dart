import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poke_detail/data/local/database/pokemon_database.dart';
import 'package:poke_detail/domain/model/pokemon.dart';
import 'package:poke_detail/domain/use_case/platform_channel/notify_back_method_uc.dart';
import 'package:poke_detail/domain/use_case/pokemon/get_abilities_uc.dart';
import 'package:poke_detail/domain/use_case/pokemon/get_moves_uc.dart';
import 'package:poke_detail/domain/use_case/pokemon/get_pokemon_uc.dart';
import 'package:poke_detail/ui/screen/pokemon_detail/bloc/pokemon_detail_bloc.dart';

class MockGetPokemonUseCase extends Mock implements GetPokemonUseCase {}

class MockNotifyBackMethodUseCase extends Mock implements NotifyBackMethodUseCase {}

class MockGetAbilitiesUseCase extends Mock implements GetAbilitiesUseCase {}

class MockGetMovesUseCase extends Mock implements GetMovesUseCase {}

class MockPokemonDatabase extends Mock implements PokemonDatabase {}

void main() {
  late PokemonDetailBloc bloc;
  late MockGetPokemonUseCase mockGetPokemonUseCase;
  late MockNotifyBackMethodUseCase mockNotifyBackMethodUseCase;
  late MockGetAbilitiesUseCase mockGetAbilitiesUseCase;
  late MockGetMovesUseCase mockGetMovesUseCase;
  late MockPokemonDatabase mockPokemonDatabase;

  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();

    mockGetPokemonUseCase = MockGetPokemonUseCase();
    mockNotifyBackMethodUseCase = MockNotifyBackMethodUseCase();
    mockGetAbilitiesUseCase = MockGetAbilitiesUseCase();
    mockGetMovesUseCase = MockGetMovesUseCase();
    mockPokemonDatabase = MockPokemonDatabase();

    bloc = PokemonDetailBloc(
      mockGetPokemonUseCase,
      mockNotifyBackMethodUseCase,
      mockGetAbilitiesUseCase,
      mockGetMovesUseCase,
    );
  });

  group('PokemonDetailBloc', () {
    const pokemonId = 1;
    const pokemon = Pokemon(
      id: pokemonId,
      name: 'Pikachu',
      abilities: [],
      moves: [],
      image: '',
      imageHD: '',
    );

    blocTest<PokemonDetailBloc, PokemonDetailState>(
      'emits [loading, loaded] when ValueReceivedEvent is added',
      build: () {
        when(() => mockGetPokemonUseCase(pokemonId)).thenAnswer((_) async => pokemon);
        when(() => mockGetAbilitiesUseCase([])).thenAnswer((_) async => []);
        when(() => mockGetMovesUseCase([])).thenAnswer((_) async => []);
        return bloc;
      },
      act: (bloc) => bloc.add(ValueReceivedEvent(pokemonId)),
      expect: () => [
        PokemonDetailState(isLoading: true, pokemon: null),
      ],
    );

    blocTest<PokemonDetailBloc, PokemonDetailState>(
      'calls NotifyBackMethodUseCase when BackPokemonDetailEvent is added',
      build: () => bloc,
      act: (bloc) => bloc.add(BackPokemonDetailEvent()),
      verify: (_) {
        verify(() => mockNotifyBackMethodUseCase()).called(1);
      },
    );
  });
}
