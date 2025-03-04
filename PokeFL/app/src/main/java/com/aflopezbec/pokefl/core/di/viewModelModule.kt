package com.aflopezbec.pokefl.core.di

import com.aflopezbec.pokefl.ui.views.home.PokedexViewModel
import org.koin.androidx.viewmodel.dsl.viewModel
import org.koin.dsl.module

val viewModelModule = module {
    viewModel { PokedexViewModel(get(), get(), get(), get()) }
}