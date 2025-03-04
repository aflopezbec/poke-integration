package com.aflopezbec.pokefl.domain.repository

sealed class ServerResponse<out T> {
    data class Success<T>(val data: T) : ServerResponse<T>()
    data class Error(val exception: Exception) : ServerResponse<Nothing>()
}