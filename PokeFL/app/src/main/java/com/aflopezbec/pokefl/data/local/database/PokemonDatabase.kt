package com.aflopezbec.pokefl.data.local.database

import androidx.room.Database
import androidx.room.RoomDatabase
import com.aflopezbec.pokefl.data.local.dao.PokemonDao
import com.aflopezbec.pokefl.data.local.entity.PokemonEntity

@Database(entities = [PokemonEntity::class], version = 1, exportSchema = false)
abstract class PokemonDatabase : RoomDatabase() {
    abstract fun pokemonDao(): PokemonDao
}