package com.aflopezbec.pokefl.core.router

import androidx.compose.runtime.Composable
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.aflopezbec.pokefl.ui.views.home.HomeScreen
import com.aflopezbec.pokefl.ui.views.splash.SplashScreen

@Composable
fun AppNavigator() {
    val navController = rememberNavController()

    NavHost(navController, startDestination = "splash") {
        composable("splash") { SplashScreen(navController) }
        composable("home") { HomeScreen() } // Tu pantalla principal
    }
}