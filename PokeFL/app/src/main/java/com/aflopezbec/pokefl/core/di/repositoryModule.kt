package com.aflopezbec.pokefl.core.di

import com.aflopezbec.pokefl.data.repository.PokedexRepositoryImpl
import com.aflopezbec.pokefl.domain.repository.PokedexRepository
import org.koin.android.ext.koin.androidContext
import org.koin.dsl.module

val repositoryModule = module {
    single<PokedexRepository> { PokedexRepositoryImpl(get(), get(), androidContext()) }
}