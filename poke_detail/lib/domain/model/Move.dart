import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:poke_detail/data/dto/move_dto.dart';
import 'package:poke_detail/data/dto/translation_dto.dart';

class Move extends Equatable {
  final String name;
  final String? url;
  final List<TranslationDto>? translations;

  Move({
    required this.name,
    this.url,
    this.translations,
  });

  static Move fromDto(MoveDto dto) {
    return Move(name: dto.name, url: dto.url, translations: dto.translations);
  }

  MoveDto toDto() {
    return MoveDto(name, url, translations);
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
