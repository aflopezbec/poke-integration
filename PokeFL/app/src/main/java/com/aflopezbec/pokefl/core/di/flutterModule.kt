package com.aflopezbec.pokefl.core.di

import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.MethodChannel
import org.koin.android.ext.koin.androidContext
import org.koin.dsl.module

val flutterModule = module {
    val FLUTTER_DETAIL_CHANNEL = "com.aflopezbec.poke_detail_channel"

    single<FlutterEngine> {
        val flutterEngine = FlutterEngine(androidContext())
        flutterEngine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint.createDefault()
        )

        FlutterEngineCache
            .getInstance()
            .put("flutter_pokemon_detail", flutterEngine)

        flutterEngine.lifecycleChannel.appIsResumed()

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            FLUTTER_DETAIL_CHANNEL
        ).setMethodCallHandler { call, result ->
            if (call.method == "back_method") {
                flutterEngine.lifecycleChannel.appIsResumed()
                flutterEngine.navigationChannel.popRoute()
            } else {
                result.success(null)
            }
        }

        return@single flutterEngine
    }


}