package com.aflopezbec.pokefl.domain.usecase

import com.aflopezbec.pokefl.domain.model.Pokemon
import com.aflopezbec.pokefl.domain.repository.PokedexRepository
import com.aflopezbec.pokefl.domain.repository.ServerResponse

class GetPokemonDetailsUseCase(private val repository: PokedexRepository) {
    suspend operator fun invoke(id: Int): ServerResponse<Pokemon> {
        return repository.getPokemonDetails(id)
    }
}