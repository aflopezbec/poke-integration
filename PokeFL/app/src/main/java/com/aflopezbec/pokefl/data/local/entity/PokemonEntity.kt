package com.aflopezbec.pokefl.data.local.entity

import androidx.room.Entity
import androidx.room.PrimaryKey
import com.aflopezbec.pokefl.domain.model.Pokemon

@Entity(tableName = "pokemon")
data class PokemonEntity(
    @PrimaryKey val id: Int,
    val name: String,
    val imageUrl: String,
    val imageFilePath: String?
)

fun Pokemon.toEntity(): PokemonEntity {
    return PokemonEntity(
        id = this.id,
        name = this.name,
        imageUrl = this.imageUrl,
        imageFilePath = null,
    )
}

fun PokemonEntity.toDomain(): Pokemon {
    return Pokemon(
        id = this.id,
        name = this.name,
        imageUrl = this.imageUrl,
        imageFilePath = null,
    )
}