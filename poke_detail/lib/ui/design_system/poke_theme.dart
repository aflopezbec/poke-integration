import 'package:flutter/material.dart';
import 'package:poke_detail/ui/design_system/tokens/poke_colors.dart';

class PokeTheme {
  const PokeTheme._();

  static ThemeData of(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      colorScheme: ColorScheme.fromSeed(
        seedColor: PokeColors.grey,
        primary: PokeColors.grey,
        primaryContainer: PokeColors.white,
        secondary: PokeColors.grey,
        surface: PokeColors.white,
        surfaceTint: PokeColors.white,
        onSurface: PokeColors.grey,
        surfaceContainerLow: PokeColors.white,
        surfaceContainerLowest: PokeColors.white,
        surfaceContainer: PokeColors.white,
        surfaceContainerHigh: PokeColors.white,
        surfaceContainerHighest: PokeColors.white,
      ),
      scaffoldBackgroundColor: PokeColors.white,
    );
  }
}
