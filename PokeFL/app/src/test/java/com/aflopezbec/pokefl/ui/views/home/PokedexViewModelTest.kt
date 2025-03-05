package com.aflopezbec.pokefl.ui.views.home

import com.aflopezbec.pokefl.core.service.NetworkMonitor
import com.aflopezbec.pokefl.domain.model.Pokemon
import com.aflopezbec.pokefl.domain.repository.ServerResponse
import com.aflopezbec.pokefl.domain.usecase.GetPokemonDetailsUseCase
import com.aflopezbec.pokefl.domain.usecase.GetPokemonListUseCase
import com.aflopezbec.pokefl.utils.MainCoroutineRule
import io.flutter.embedding.engine.FlutterEngine
import io.mockk.coEvery
import io.mockk.every
import io.mockk.mockk
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.test.advanceUntilIdle
import kotlinx.coroutines.test.runTest
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNull
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import org.junit.rules.TestRule
import org.junit.runner.RunWith
import org.junit.runners.JUnit4

@OptIn(ExperimentalCoroutinesApi::class)
@RunWith(JUnit4::class)
class PokedexViewModelTest {

    @get:Rule
    val testRule: TestRule = MainCoroutineRule()

    private lateinit var viewModel: PokedexViewModel
    private val getPokemonListUseCase: GetPokemonListUseCase = mockk()
    private val getPokemonDetailsUseCase: GetPokemonDetailsUseCase = mockk()
    private val networkMonitor: NetworkMonitor = mockk()
    private val flutterEngine: FlutterEngine = mockk()

    val mockPokemons = listOf(
        Pokemon(1, "Pikachu", "http://image.png", null),
        Pokemon(2, "Charmander", "http://image.png", null)
    )

    @Before
    fun setup() {
        every { networkMonitor.isConnected } returns MutableStateFlow(true)

        viewModel = PokedexViewModel(
            getPokemonListUseCase,
            getPokemonDetailsUseCase,
            networkMonitor,
            flutterEngine
        )
    }

    @Test
    fun `fetchPokemonList should update pokemonList on success`() = runTest {
        coEvery { getPokemonListUseCase(any()) } returns ServerResponse.Success(mockPokemons)

        advanceUntilIdle()

        assertEquals(mockPokemons, viewModel.pokemonList.value)
    }

    @Test
    fun `fetchPokemonList should update errorMessage on failure`() = runTest {
        val errorMessage = "Network error"
        coEvery { getPokemonListUseCase(any()) } returns ServerResponse.Error(Exception(errorMessage))

        advanceUntilIdle()

        assertEquals(errorMessage, viewModel.errorMessage.value)
    }

    @Test
    fun `getPokemonDetails should return pokemon on success`() = runTest {
        val mockPokemon = Pokemon(1, "Pikachu", "http://image.png", null)
        coEvery { getPokemonListUseCase(any()) } returns ServerResponse.Success(mockPokemons)
        coEvery { getPokemonDetailsUseCase(any()) } returns ServerResponse.Success(
            mockPokemon
        )

        val result = viewModel.getPokemonDetails(1)

        advanceUntilIdle()

        assertEquals(mockPokemon, result)
    }

    @Test
    fun `getPokemonDetails should return null on failure and update errorMessage`() = runTest {
        val errorMessage = "Failed to fetch"
        coEvery { getPokemonListUseCase(any()) } returns ServerResponse.Success(mockPokemons)
        coEvery { getPokemonListUseCase(any()) } returns ServerResponse.Success(mockPokemons)
        coEvery { getPokemonDetailsUseCase(1) } returns ServerResponse.Error(Exception(errorMessage))

        val result = viewModel.getPokemonDetails(1)

        assertNull(result)
        assertEquals(errorMessage, viewModel.errorMessage.value)
    }
}