package com.aflopezbec.pokefl.data.remote.dto

import com.google.gson.annotations.SerializedName

data class PokemonDetailsResponseDto(
    val id: Int,
    val name: String,
    val sprites: SpritesDto
)

data class SpritesDto(
    val other: OtherSpritesDto
)

data class OtherSpritesDto(
    @SerializedName("official-artwork") val officialArtwork: OfficialArtworkDto
)

data class OfficialArtworkDto(
    @SerializedName("front_default") val frontDefault: String
)