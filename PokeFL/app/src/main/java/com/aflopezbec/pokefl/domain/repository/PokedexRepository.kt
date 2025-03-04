package com.aflopezbec.pokefl.domain.repository

import com.aflopezbec.pokefl.domain.model.Pokemon

interface PokedexRepository {
    suspend fun getPokemonList(offset: Int): ServerResponse<List<Pokemon>>
    suspend fun getPokemonDetails(id: Int): ServerResponse<Pokemon>
}