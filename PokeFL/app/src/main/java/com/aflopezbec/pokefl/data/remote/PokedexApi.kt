package com.aflopezbec.pokefl.data.remote

import com.aflopezbec.pokefl.data.remote.dto.PokemonDetailsResponseDto
import com.aflopezbec.pokefl.data.remote.dto.PokemonListResponseDto
import retrofit2.http.GET
import retrofit2.http.Path
import retrofit2.http.Query


interface PokedexApi {
    @GET("pokemon")
    suspend fun getPokemonList(
        @Query("limit") limit: Int,
        @Query("offset") offset: Int
    ): PokemonListResponseDto

    @GET("pokemon/{id}")
    suspend fun getPokemonDetails(
        @Path("id") id: Int
    ): PokemonDetailsResponseDto
}