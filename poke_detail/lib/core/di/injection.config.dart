// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/repository/pokemon_repository_impl.dart' as _i209;
import '../../domain/repository/pokemon_repository.dart' as _i226;
import '../../domain/use_case/platform_channel/notify_back_method_uc.dart'
    as _i510;
import '../../domain/use_case/pokemon/get_abilities_uc.dart' as _i799;
import '../../domain/use_case/pokemon/get_moves_uc.dart' as _i31;
import '../../domain/use_case/pokemon/get_pokemon_uc.dart' as _i93;
import '../../ui/screen/pokemon_detail/bloc/pokemon_detail_bloc.dart' as _i171;
import '../network/http_provider.dart' as _i427;
import 'injection.dart' as _i464;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.factory<_i510.NotifyBackMethodUseCase>(
      () => _i510.NotifyBackMethodUseCase());
  gh.lazySingleton<_i361.Dio>(() => registerModule.dio());
  gh.lazySingleton<_i427.HttpProvider>(
      () => _i427.HttpProvider(gh<_i361.Dio>()));
  gh.factory<_i226.PokemonRepository>(
      () => _i209.PokemonRepositoryImpl(gh<_i427.HttpProvider>()));
  gh.factory<_i799.GetAbilitiesUseCase>(
      () => _i799.GetAbilitiesUseCase(gh<_i226.PokemonRepository>()));
  gh.factory<_i31.GetMovesUseCase>(
      () => _i31.GetMovesUseCase(gh<_i226.PokemonRepository>()));
  gh.factory<_i93.GetPokemonUseCase>(
      () => _i93.GetPokemonUseCase(gh<_i226.PokemonRepository>()));
  gh.factory<_i171.PokemonDetailBloc>(() => _i171.PokemonDetailBloc(
        gh<_i93.GetPokemonUseCase>(),
        gh<_i510.NotifyBackMethodUseCase>(),
        gh<_i799.GetAbilitiesUseCase>(),
        gh<_i31.GetMovesUseCase>(),
      ));
  return getIt;
}

class _$RegisterModule extends _i464.RegisterModule {}
