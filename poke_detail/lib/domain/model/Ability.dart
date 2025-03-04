import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:poke_detail/data/dto/ability_dto.dart';
import 'package:poke_detail/data/dto/translation_dto.dart';

class Ability extends Equatable {
  final String name;
  final String? url;
  final List<TranslationDto>? translations;

  Ability({
    required this.name,
    this.url,
    this.translations,
  });

  static Ability fromDto(AbilityDto dto) {
    return Ability(name: dto.name, url: dto.url, translations: dto.translations);
  }

  AbilityDto toDto() {
    return AbilityDto(name, url, translations);
  }

  String displayName(String localLanguage) {
    return translations
            ?.firstWhereOrNull(
              (t) => t.language.name == localLanguage,
            )
            ?.name ??
        name;
  }

  @override
  List<Object?> get props => [name, url, translations];
}
