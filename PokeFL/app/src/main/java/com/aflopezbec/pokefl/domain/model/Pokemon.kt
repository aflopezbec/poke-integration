package com.aflopezbec.pokefl.domain.model

import com.aflopezbec.pokefl.data.remote.dto.PokemonDetailsResponseDto

data class Pokemon(
    val id: Int,
    val name: String,
    val imageUrl: String
)

fun PokemonDetailsResponseDto.toDomain(): Pokemon {
    return Pokemon(
        id = this.id,
        name = this.name,
        imageUrl = this.sprites.other.officialArtwork.frontDefault
    )
}