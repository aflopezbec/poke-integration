// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i2;
import 'package:flutter/material.dart' as _i3;
import 'package:poke_detail/ui/screen/pokemon_detail/pokemon_detail_screen.dart'
    as _i1;

/// generated route for
/// [_i1.PokemonDetailScreen]
class PokemonDetailRoute extends _i2.PageRouteInfo<PokemonDetailRouteArgs> {
  PokemonDetailRoute({
    _i3.Key? key,
    required int id,
    List<_i2.PageRouteInfo>? children,
  }) : super(
         PokemonDetailRoute.name,
         args: PokemonDetailRouteArgs(key: key, id: id),
         rawPathParams: {'id': id},
         initialChildren: children,
       );

  static const String name = 'PokemonDetailRoute';

  static _i2.PageInfo page = _i2.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<PokemonDetailRouteArgs>(
        orElse: () => PokemonDetailRouteArgs(id: pathParams.getInt('id')),
      );
      return _i1.PokemonDetailScreen(key: args.key, id: args.id);
    },
  );
}

class PokemonDetailRouteArgs {
  const PokemonDetailRouteArgs({this.key, required this.id});

  final _i3.Key? key;

  final int id;

  @override
  String toString() {
    return 'PokemonDetailRouteArgs{key: $key, id: $id}';
  }
}
