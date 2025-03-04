import 'package:get_it/get_it.dart';
import 'package:poke_detail/core/di/injection.dart';

class PokeLocator {
  static final _getIt = GetIt.instance;

  PokeLocator._();

  static T get<T extends Object>() {
    return _getIt.get();
  }

  static void init() {
    configureDependencies();
  }
}
