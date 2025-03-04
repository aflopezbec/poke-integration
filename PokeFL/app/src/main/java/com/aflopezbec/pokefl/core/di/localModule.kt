package com.aflopezbec.pokefl.core.di

import android.app.Application
import androidx.room.Room
import com.aflopezbec.pokefl.core.service.NetworkMonitor
import com.aflopezbec.pokefl.data.local.database.PokemonDatabase
import org.koin.android.ext.koin.androidContext
import org.koin.dsl.module

val localModule = module {
    single {
        Room.databaseBuilder(get<Application>(), PokemonDatabase::class.java, "poke_fl.db")
            .fallbackToDestructiveMigration()
            .build()
    }

    single { get<PokemonDatabase>().pokemonDao() }
    single { NetworkMonitor(androidContext()) }
}