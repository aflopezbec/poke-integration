import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:poke_detail/domain/model/pokemon.dart';
import 'package:poke_detail/l10n/app_localizations.dart';
import 'package:poke_detail/ui/design_system/tokens/poke_colors.dart';
import 'package:poke_detail/ui/design_system/tokens/poke_text_style.dart';

class PokemonDetailWidget extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetailWidget({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final ImageProvider provider = NetworkImage(pokemon.image);

    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder(
            future: ColorScheme.fromImageProvider(provider: provider),
            builder: (ctx, snap) {
              return Container(
                margin: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: snap.data?.onInverseSurface,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: CachedNetworkImage(
                  imageUrl: pokemon.imageHD,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(value: downloadProgress.progress),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ExpansionTile(
              title: Text(AppLocalizations.current.ability_title, style: PokeTextStyle.subtitle),
              backgroundColor: PokeColors.yellowLight,
              collapsedIconColor: PokeColors.yellow,
              iconColor: PokeColors.yellow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              collapsedBackgroundColor: PokeColors.yellowLight,
              collapsedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              children: pokemon.abilities
                  .map(
                    (ability) => ListTile(
                      title: Text(
                        ability.displayName(AppLocalizations.current.localeName),
                        style: PokeTextStyle.body,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0).copyWith(
              bottom: 32.0,
            ),
            child: ExpansionTile(
              title: Text(AppLocalizations.current.moves_title, style: PokeTextStyle.subtitle),
              backgroundColor: PokeColors.orangeLight,
              collapsedIconColor: PokeColors.orange,
              iconColor: PokeColors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              collapsedBackgroundColor: PokeColors.orangeLight,
              collapsedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              children: pokemon.moves
                  .map(
                    (move) => ListTile(
                      title: Text(
                        move.displayName(AppLocalizations.current.localeName),
                        style: PokeTextStyle.body,
                      ),
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
