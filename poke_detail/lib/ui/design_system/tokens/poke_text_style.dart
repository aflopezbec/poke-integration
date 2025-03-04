import 'package:flutter/cupertino.dart';
import 'package:poke_detail/ui/design_system/tokens/poke_colors.dart';

class PokeTextStyle {
  const PokeTextStyle._();

  static const title = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: PokeColors.grey,
  );

  static const subtitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: PokeColors.grey,
  );

  static const body = TextStyle(
    fontSize: 14,
    color: PokeColors.grey,
  );

  static const bodyBold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: PokeColors.grey,
  );

  static const button = TextStyle(
    fontSize: 14,
    color: PokeColors.white,
  );

  static const buttonBold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: PokeColors.white,
  );

  static const caption = TextStyle(
    fontSize: 12,
    color: PokeColors.grey,
  );
}
