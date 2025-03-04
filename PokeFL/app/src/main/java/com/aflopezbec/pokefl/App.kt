package com.aflopezbec.pokefl

import android.app.Application
import com.aflopezbec.pokefl.core.di.flutterModule
import com.aflopezbec.pokefl.core.di.localModule
import com.aflopezbec.pokefl.core.di.networkModule
import com.aflopezbec.pokefl.core.di.repositoryModule
import com.aflopezbec.pokefl.core.di.useCaseModule
import com.aflopezbec.pokefl.core.di.viewModelModule
import org.koin.android.ext.koin.androidContext
import org.koin.core.context.startKoin

class App : Application() {
    override fun onCreate() {
        super.onCreate()
        startKoin {
            androidContext(this@App)
            modules(
                listOf(
                    networkModule,
                    localModule,
                    repositoryModule,
                    useCaseModule,
                    viewModelModule,
                    flutterModule
                )
            )
        }
    }
}