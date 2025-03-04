package com.aflopezbec.pokefl.ui.views.home

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.aflopezbec.pokefl.core.service.NetworkMonitor
import com.aflopezbec.pokefl.domain.model.Pokemon
import com.aflopezbec.pokefl.domain.repository.ServerResponse
import com.aflopezbec.pokefl.domain.usecase.GetPokemonDetailsUseCase
import com.aflopezbec.pokefl.domain.usecase.GetPokemonListUseCase
import io.flutter.embedding.engine.FlutterEngine
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.launch

class PokedexViewModel(
    private val getPokemonListUseCase: GetPokemonListUseCase,
    private val getPokemonDetailsUseCase: GetPokemonDetailsUseCase,
    private val networkMonitor: NetworkMonitor,
    val flutterEngine: FlutterEngine
) : ViewModel() {
    private val _pokemonList = MutableStateFlow<List<Pokemon>>(emptyList())
    private val _errorMessage = MutableStateFlow<String?>(null)

    val pokemonList: StateFlow<List<Pokemon>> get() = _pokemonList
    val errorMessage: StateFlow<String?> = _errorMessage
    val isConnected = networkMonitor.isConnected

    private var currentOffset = 0
    private val pageSize = 20
    private var isLoading = false

    init {
        observeIsConnected()
    }

    private fun observeIsConnected() {
        viewModelScope.launch {
            isConnected.collect { newState ->
                if (pokemonList.value.isEmpty() && newState) {
                    fetchPokemonList()
                }
            }
        }
    }

    fun fetchPokemonList() {
        if (isLoading) {
            return
        }
        viewModelScope.launch {
            isLoading = true
            when (val response = getPokemonListUseCase(currentOffset)) {
                is ServerResponse.Success -> {
                    _pokemonList.value += response.data
                    currentOffset += pageSize
                    isLoading = false
                }

                is ServerResponse.Error -> {
                    _errorMessage.value = response.exception.message
                    isLoading = false
                }
            }

        }
    }

    suspend fun getPokemonDetails(pokemonId: Int): Pokemon? {
        return when (val response = getPokemonDetailsUseCase(pokemonId)) {
            is ServerResponse.Success -> {
                response.data
            }

            is ServerResponse.Error -> {
                _errorMessage.value = response.exception.message
                return null
            }
        }
    }
}