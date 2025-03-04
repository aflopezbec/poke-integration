import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_detail/core/di/poke_locator.dart';
import 'package:poke_detail/core/extension/string_ext.dart';
import 'package:poke_detail/ui/design_system/tokens/poke_colors.dart';
import 'package:poke_detail/ui/design_system/tokens/poke_text_style.dart';
import 'package:poke_detail/ui/screen/pokemon_detail/bloc/pokemon_detail_bloc.dart';
import 'package:poke_detail/ui/screen/pokemon_detail/widget/pokemon_detail_widget.dart';

@RoutePage()
class PokemonDetailScreen extends StatefulWidget {
  const PokemonDetailScreen({super.key, @PathParam('id') required this.id});

  final int id;

  @override
  PokemonDetailScreenState createState() => PokemonDetailScreenState();
}

class PokemonDetailScreenState extends State<PokemonDetailScreen> {
  final _bloc = PokeLocator.get<PokemonDetailBloc>();

  @override
  void initState() {
    super.initState();
    _bloc.add(ValueReceivedEvent(widget.id));
  }

  @override
  void didUpdateWidget(covariant PokemonDetailScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    _bloc.add(ValueReceivedEvent(widget.id));
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonDetailBloc, PokemonDetailState>(
        bloc: _bloc,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: PokeColors.grey,
                ),
                onPressed: () => _bloc.add(BackPokemonDetailEvent()),
              ),
              centerTitle: true,
              title: Text(
                state.pokemon?.name.capitalize() ?? "-",
                style: PokeTextStyle.title,
                textAlign: TextAlign.center,
              ),
            ),
            body: Builder(
              builder: (context) {
                if (state.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!state.isLoading && state.pokemon == null) {
                  return const Center(
                    child: Text('Something went wrong'),
                  );
                }
                return PokemonDetailWidget(pokemon: state.pokemon!);
              },
            ),
          );
        });
  }
}
