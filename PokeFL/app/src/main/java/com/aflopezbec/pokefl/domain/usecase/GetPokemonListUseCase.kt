package com.aflopezbec.pokefl.domain.usecase

import com.aflopezbec.pokefl.domain.model.Pokemon
import com.aflopezbec.pokefl.domain.repository.PokedexRepository
import com.aflopezbec.pokefl.domain.repository.ServerResponse

class GetPokemonListUseCase(private val repository: PokedexRepository) {
    suspend operator fun invoke(offset: Int): ServerResponse<List<Pokemon>> {
        return repository.getPokemonList(offset)
    }
}