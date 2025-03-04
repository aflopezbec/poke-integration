package com.aflopezbec.pokefl.core.di

import com.aflopezbec.pokefl.domain.usecase.GetPokemonDetailsUseCase
import com.aflopezbec.pokefl.domain.usecase.GetPokemonListUseCase
import org.koin.dsl.module

val useCaseModule = module {
    factory { GetPokemonListUseCase(get()) }
    factory { GetPokemonDetailsUseCase(get()) }
}