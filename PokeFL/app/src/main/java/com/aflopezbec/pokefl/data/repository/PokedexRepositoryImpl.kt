package com.aflopezbec.pokefl.data.repository

import android.content.Context
import android.graphics.Bitmap
import coil3.ImageLoader
import coil3.request.ImageRequest
import coil3.request.SuccessResult
import coil3.request.allowHardware
import coil3.toBitmap
import com.aflopezbec.pokefl.data.local.dao.PokemonDao
import com.aflopezbec.pokefl.data.local.entity.toDomain
import com.aflopezbec.pokefl.data.local.entity.toEntity
import com.aflopezbec.pokefl.data.remote.PokedexApi
import com.aflopezbec.pokefl.domain.model.Pokemon
import com.aflopezbec.pokefl.domain.model.toDomain
import com.aflopezbec.pokefl.domain.repository.PokedexRepository
import com.aflopezbec.pokefl.domain.repository.ServerResponse
import com.aflopezbec.pokefl.utils.Constants
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import java.io.File
import java.io.FileOutputStream

class PokedexRepositoryImpl(
    private val api: PokedexApi,
    private val pokemonDao: PokemonDao,
    private val context: Context
) : PokedexRepository {
    override suspend fun getPokemonList(offset: Int): ServerResponse<List<Pokemon>> {
        return try {
            val response = api.getPokemonList(offset = offset, limit = Constants.LIMIT)
            val pokemonList = response.results.map { item ->
                val id = item.url.split("/").dropLast(1).last().toInt()
                val imageUrl = Constants.IMAGE_URL.replace(Constants.POKEMON_ID, id.toString())
                Pokemon(
                    id,
                    item.name,
                    imageUrl
                )
            }
            CoroutineScope(Dispatchers.IO).launch {
                saveToLocal(pokemonList)
            }
            ServerResponse.Success(pokemonList)
        } catch (e: Exception) {
            val localData = pokemonDao.getAllByLimit(offset, Constants.LIMIT).map { it.toDomain() }
            if (localData.isNotEmpty()) {
                ServerResponse.Success(localData)
            } else {
                ServerResponse.Error(e)
            }
        }
    }

    override suspend fun getPokemonDetails(id: Int): ServerResponse<Pokemon> {
        return try {
            val response = api.getPokemonDetails(id)
            val pokemon = response.toDomain()
            pokemonDao.insert(pokemon.toEntity())
            ServerResponse.Success(pokemon)
        } catch (e: Exception) {
            pokemonDao.getById(id)?.toDomain()?.let {
                ServerResponse.Success(it)
            } ?: ServerResponse.Error(e)
        }
    }

    private suspend fun saveToLocal(pokemons: List<Pokemon>) {
        val pokemonList = pokemons.map { pokemon ->
            val imageUrl = cacheImage(pokemon.imageUrl, pokemon.id)
            pokemon.copy(imageUrl = imageUrl ?: pokemon.imageUrl)
        }
        pokemonDao.insertAll(pokemonList.map { it.toEntity() })
    }

    private suspend fun cacheImage(imageUrl: String, pokemonId: Int): String? {
        return try {
            val loader = ImageLoader(context)
            val request = ImageRequest.Builder(context)
                .data(imageUrl)
                .allowHardware(false) // Necesario para obtener un Bitmap
                .build()

            val result = (loader.execute(request) as? SuccessResult)?.image
            val bitmap = result?.toBitmap()

            if (bitmap != null) {
                val file = File(context.cacheDir, "pokemon_$pokemonId.png")
                withContext(Dispatchers.IO) {
                    FileOutputStream(file).use { out ->
                        bitmap.compress(Bitmap.CompressFormat.PNG, 100, out)
                    }
                }
                return file.absolutePath
            }

            null
        } catch (e: Exception) {
            null
        }
    }
}