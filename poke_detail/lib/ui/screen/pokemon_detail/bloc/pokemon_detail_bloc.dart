import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:poke_detail/data/local/database/pokemon_database.dart';
import 'package:poke_detail/domain/model/pokemon.dart';
import 'package:poke_detail/domain/use_case/platform_channel/notify_back_method_uc.dart';
import 'package:poke_detail/domain/use_case/pokemon/get_abilities_uc.dart';
import 'package:poke_detail/domain/use_case/pokemon/get_moves_uc.dart';
import 'package:poke_detail/domain/use_case/pokemon/get_pokemon_uc.dart';

part 'pokemon_detail_event.dart';
part 'pokemon_detail_state.dart';

@injectable
class PokemonDetailBloc extends Bloc<PokemonDetailEvent, PokemonDetailState> {
  final GetPokemonUseCase _getPokemonUseCase;
  final NotifyBackMethodUseCase _notifyBackMethodUseCase;
  final GetAbilitiesUseCase _getAbilitiesUseCase;
  final GetMovesUseCase _getMovesUseCase;
  final PokemonDatabase _pokemonDatabase = PokemonDatabase.instance;

  PokemonDetailBloc(
    this._getPokemonUseCase,
    this._notifyBackMethodUseCase,
    this._getAbilitiesUseCase,
    this._getMovesUseCase,
  ) : super(const PokemonDetailState()) {
    on<SetPokemonEvent>(_onSetPokemon);
    on<BackPokemonDetailEvent>(_onBackPokemonDetail);
    on<ValueReceivedEvent>(_onValueReceived);
  }

  void _onSetPokemon(SetPokemonEvent event, Emitter<PokemonDetailState> emit) {
    emit(state.copyWith(pokemon: () => event.pokemon));
  }

  void _onBackPokemonDetail(
    BackPokemonDetailEvent event,
    Emitter<PokemonDetailState> emit,
  ) {
    _notifyBackMethodUseCase();
  }

  Future<void> _onValueReceived(
    ValueReceivedEvent event,
    Emitter<PokemonDetailState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, pokemon: () => null));
    try {
      final localPokemon = await _pokemonDatabase.getPokemonById(event.value);
    } catch (e) {
      print("ERROR -> ${e}");
    }

    Pokemon? pokemon = await _getPokemonUseCase(event.value);
    emit(state.copyWith(id: event.value, pokemon: () => pokemon, isLoading: false));

    final abilities = await _getAbilitiesUseCase(pokemon?.abilities ?? []);
    pokemon = pokemon?.copyWith(abilities: abilities);
    emit(state.copyWith(pokemon: () => pokemon));

    final moves = await _getMovesUseCase(pokemon?.moves ?? []);
    pokemon = pokemon?.copyWith(moves: moves);
    emit(state.copyWith(pokemon: () => pokemon));
  }

  void dispose() {
    super.close();
  }
}
