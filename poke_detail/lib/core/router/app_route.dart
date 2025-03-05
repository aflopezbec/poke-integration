import 'package:auto_route/auto_route.dart';
import 'package:poke_detail/core/router/app_route.gr.dart';
import 'package:poke_detail/ui/screen/pokemon_detail/pokemon_detail_screen.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        NamedRouteDef(
          initial: true,
          keepHistory: false,
          name: PokemonDetailRoute.name,
          path: '/pokemon/:id',
          builder: (context, data) => PokemonDetailScreen(
            id: data.params.getInt('id', 0),
          ),
        ),
      ];
}
