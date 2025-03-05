package com.aflopezbec.pokefl.ui.views.home

import android.content.Context
import android.widget.Toast
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.WindowInsets
import androidx.compose.foundation.layout.asPaddingValues
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.systemBars
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyGridState
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.foundation.lazy.grid.rememberLazyGridState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.derivedStateOf
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.toArgb
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.colorResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.palette.graphics.Palette
import coil3.compose.AsyncImagePainter
import coil3.compose.rememberAsyncImagePainter
import coil3.request.ImageRequest
import coil3.request.SuccessResult
import coil3.request.allowHardware
import coil3.toBitmap
import com.aflopezbec.pokefl.R
import com.aflopezbec.pokefl.domain.model.Pokemon
import com.aflopezbec.pokefl.utils.Constants
import com.aflopezbec.pokefl.utils.singleClick
import com.google.accompanist.placeholder.PlaceholderHighlight
import com.google.accompanist.placeholder.material.placeholder
import com.google.accompanist.placeholder.material.shimmer
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.FlutterActivityLaunchConfigs
import io.flutter.embedding.engine.FlutterEngine
import org.koin.androidx.compose.koinViewModel
import java.io.File
import java.util.Locale

@Composable
fun HomeScreen(
    viewModel: PokedexViewModel = koinViewModel(),
) {
    val context = LocalContext.current
    val pokemonList by viewModel.pokemonList.collectAsState()
    val isConnected by viewModel.isConnected.collectAsState(initial = true)
    val errorMessage by viewModel.errorMessage.collectAsState()

    val listState = rememberLazyGridState()

    val error = stringResource(R.string.get_data_error_title)
    LaunchedEffect(errorMessage) {
        errorMessage?.let {
            Toast.makeText(context, error, Toast.LENGTH_SHORT)
                .show()
        }
    }

    val shouldLoadMore = remember {
        derivedStateOf {
            val lastVisibleIndex = listState.layoutInfo.visibleItemsInfo.lastOrNull()?.index ?: -1
            lastVisibleIndex >= pokemonList.size - 1
        }
    }

    LaunchedEffect(shouldLoadMore.value) {
        if (shouldLoadMore.value) {
            viewModel.fetchPokemonList()
        }
    }


    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(WindowInsets.systemBars.asPaddingValues())
    ) {
        if (!isConnected) {
            NotInternetBox()
        }
        HomeViewPreviewContent(
            pokemonList,
            listState,
            viewModel::getPokemonDetails,
            viewModel.flutterEngine,
        )

    }


}

@Composable
fun NotInternetBox() {
    Box(
        modifier = Modifier
            .background(colorResource(id = R.color.alert_background))
            .padding(8.dp)
    ) {
        Column {
            Text(
                text = stringResource(id = R.string.not_internet_connection_title),
                textAlign = TextAlign.Center,
                fontWeight = FontWeight.Bold,
                color = colorResource(id = R.color.alert_text),
                modifier = Modifier
                    .fillMaxWidth()

            )
            Text(
                text = stringResource(id = R.string.not_internet_connection_description),
                textAlign = TextAlign.Center,
                fontSize = Constants.FONT_SIZE_SMALL,
                color = colorResource(id = R.color.alert_text),
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(top = 4.dp)
            )
        }
    }
}

@Composable
fun HomeViewPreviewContent(
    pokemonList: List<Pokemon>,
    listState: LazyGridState,
    getPokemonDetails: suspend (Int) -> Pokemon?,
    flutterEngine: FlutterEngine,
) {
    val context = LocalContext.current
    LazyVerticalGrid(
        state = listState,
        columns = GridCells.Fixed(2),
        contentPadding = PaddingValues(8.dp),
        horizontalArrangement = Arrangement.Center,
        modifier = Modifier.fillMaxSize()
    ) {
        items(if (pokemonList.isEmpty()) 10 else pokemonList.size) { index ->
            if (pokemonList.isEmpty())
                PlaceholderItem()
            else PokemonItem(
                pokemon = pokemonList[index],
                getPokemonDetails = getPokemonDetails,
                flutterEngine = flutterEngine,
                context = context,
            )
        }
    }
}

@Composable
fun PlaceholderItem() {
    Card(
        shape = RoundedCornerShape(8.dp),
        modifier = Modifier
            .padding(8.dp)
            .size(120.dp)
            .placeholder(
                visible = true,
                highlight = PlaceholderHighlight.shimmer()
            )
    ) {

    }
}


@Composable
fun PokemonItem(
    pokemon: Pokemon,
    getPokemonDetails: suspend (Int) -> Pokemon?,
    flutterEngine: FlutterEngine,
    context: Context
) {
    var imageUrl by remember { mutableStateOf(pokemon.imageUrl) }
    val color = extractColorFromImage(imageUrl, context)

    Card(colors = CardDefaults.cardColors(
        containerColor = color.copy(alpha = 0.2f)
    ),
        modifier = Modifier
            .padding(8.dp)
            .fillMaxWidth()
            .clickable(
                onClick = singleClick {
                    flutterEngine.navigationChannel.pushRoute("/pokemon/${pokemon.id}")
                    context.startActivity(
                        FlutterActivity.withCachedEngine("flutter_pokemon_detail")
                            .backgroundMode(FlutterActivityLaunchConfigs.BackgroundMode.transparent)
                            .build(context)

                    )
                }
            )) {
        Box(
            modifier = Modifier
                .fillMaxSize(),
            contentAlignment = Alignment.Center
        ) {
            Column(
                horizontalAlignment = Alignment.CenterHorizontally,
                verticalArrangement = Arrangement.Center
            ) {
                val painter = rememberAsyncImagePainter(
                    imageUrl,
                )
                if (pokemon.imageFilePath != null) {
                    Image(
                        painter = rememberAsyncImagePainter(
                            File(pokemon.imageFilePath),
                        ),
                        contentDescription = pokemon.name,
                        modifier = Modifier.size(120.dp)
                    )
                } else {
                    Image(
                        painter = rememberAsyncImagePainter(
                            pokemon.imageUrl,
                        ),
                        contentDescription = pokemon.name,
                        modifier = Modifier.size(120.dp)
                    )
                }

                LaunchedEffect(painter) {
                    if (painter.state.value is AsyncImagePainter.State.Error) {
                        val localPokemon = getPokemonDetails(pokemon.id)
                        if (localPokemon != null) {
                            imageUrl = localPokemon.imageUrl
                        }
                    }
                }

                Text(
                    text = pokemon.name.replaceFirstChar {
                        if (it.isLowerCase()) it.titlecase(
                            Locale.getDefault()
                        ) else it.toString()
                    },
                    fontWeight = FontWeight.Bold,
                    color = color,
                )
            }
        }
    }
}

@Composable
fun extractColorFromImage(imageUrl: String, context: Context): Color {
    var dominantColor by remember { mutableStateOf(Color.Gray) }

    LaunchedEffect(imageUrl) {
        val request = ImageRequest.Builder(context)
            .data(imageUrl)
            .allowHardware(false)
            .build()

        val result = coil3.ImageLoader(context).execute(request)
        if (result is SuccessResult) {
            val bitmap = result.image.toBitmap()
            bitmap.let {
                val palette = Palette.from(it).generate()
                dominantColor = Color(palette.getMutedColor(Color.Gray.toArgb()))
            }
        }
    }

    return dominantColor
}

