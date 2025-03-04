package com.aflopezbec.pokefl.repository

import com.aflopezbec.pokefl.data.remote.dto.PokemonItemDto
import com.aflopezbec.pokefl.data.remote.dto.PokemonListResponseDto
import com.aflopezbec.pokefl.data.local.dao.PokemonDao
import com.aflopezbec.pokefl.data.remote.PokedexApi
import com.aflopezbec.pokefl.data.repository.PokedexRepositoryImpl
import io.mockk.coEvery
import io.mockk.mockk
import junit.framework.TestCase.assertEquals
import kotlinx.coroutines.runBlocking
import org.junit.Before
import org.junit.Test

class PokedexRepositoryTest {
    private lateinit var repository: PokedexRepositoryImpl
    private val api: PokedexApi = mockk()
    private val pokemonDao: PokemonDao = mockk()

    @Before
    fun setUp() {
        repository = PokedexRepositoryImpl(api, pokemonDao)
    }

    @Test
    fun `getPokemonList obtiene datos desde la API`() = runBlocking {
        val mockResponse = PokemonListResponseDto(listOf(PokemonItemDto("bulbasaur", "https://pokeapi.co/api/v2/pokemon/1/")))
        coEvery { api.getPokemonList(any(), any()) } returns mockResponse
        coEvery { pokemonDao.insertAll(any()) } returns Unit

        val result = repository.getPokemonList(0)

        assertEquals(1, result.size)
        assertEquals("bulbasaur", result[0].name)
    }
}