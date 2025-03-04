package com.aflopezbec.pokefl.data.remote.dto

data class PokemonListResponseDto(
    val results: List<PokemonItemDto>
)

data class PokemonItemDto(
    val name: String,
    val url: String
)