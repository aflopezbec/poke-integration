package com.aflopezbec.pokefl.repository

import com.aflopezbec.pokefl.data.local.dao.PokemonDao
import com.aflopezbec.pokefl.data.local.entity.PokemonEntity
import com.aflopezbec.pokefl.data.remote.PokedexApi
import com.aflopezbec.pokefl.data.remote.dto.PokemonItemDto
import com.aflopezbec.pokefl.data.remote.dto.PokemonListResponseDto
import com.aflopezbec.pokefl.data.repository.PokedexRepositoryImpl
import com.aflopezbec.pokefl.domain.repository.ServerResponse
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
        repository = PokedexRepositoryImpl(api, pokemonDao, mockk())
    }

    @Test
    fun `getPokemonList obtain data from api`() = runBlocking {
        val mockResponse = PokemonListResponseDto(
            listOf(
                PokemonItemDto(
                    "bulbasaur",
                    "https://pokeapi.co/api/v2/pokemon/1/"
                )
            )
        )
        coEvery { api.getPokemonList(any(), any()) } returns mockResponse
        coEvery { pokemonDao.getAllByLimit(any(), any()) } returns listOf()

        val result = repository.getPokemonList(0)
        val data = (result as ServerResponse.Success).data

        assertEquals(1, data.size)
        assertEquals("bulbasaur", data[0].name)
    }

    @Test
    fun `getPokemonList obtain data from local`() = runBlocking {
        val mockResponse = PokemonListResponseDto(
            listOf(
                PokemonItemDto(
                    "bulbasaur",
                    "https://pokeapi.co/api/v2/pokemon/1/"
                )
            )
        )

        val mockDaoResponse =
            listOf(
                PokemonEntity(
                    id = 1,
                    "pikachu",
                    "https://pokeapi.co/api/v2/pokemon/1/",
                    null
                )
            )

        coEvery { api.getPokemonList(any(), any()) } returns mockResponse
        coEvery { pokemonDao.getAllByLimit(any(), any()) } returns mockDaoResponse

        val result = repository.getPokemonList(0)
        val data = (result as ServerResponse.Success).data

        assertEquals(1, data.size)
        assertEquals("pikachu", data[0].name)
    }
}