import com.aflopezbec.pokefl.domain.model.Pokemon
import com.aflopezbec.pokefl.domain.repository.PokedexRepository
import com.aflopezbec.pokefl.domain.repository.ServerResponse
import com.aflopezbec.pokefl.domain.usecase.GetPokemonListUseCase
import io.mockk.coEvery
import io.mockk.mockk
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.test.runTest
import org.junit.Assert.assertEquals
import org.junit.Before
import org.junit.Test

@OptIn(ExperimentalCoroutinesApi::class)
class GetPokemonListUseCaseTest {

    private lateinit var repository: PokedexRepository
    private lateinit var getPokemonListUseCase: GetPokemonListUseCase

    @Before
    fun setUp() {
        repository = mockk()
        getPokemonListUseCase = GetPokemonListUseCase(repository)
    }

    @Test
    fun `invoke should return list of Pokemon`() = runTest {
        // Given
        val offset = 0
        val expectedPokemonList = listOf(
            Pokemon(1, "Pikachu", "http://image.png", "null"),
            Pokemon(2, "Charmander", "http://image.png", "null")
        )
        val expectedResponse = ServerResponse.Success(expectedPokemonList)
        coEvery { repository.getPokemonList(offset) } returns expectedResponse

        // When
        val result = getPokemonListUseCase(offset)

        // Then
        assertEquals(expectedResponse, result)
    }
}