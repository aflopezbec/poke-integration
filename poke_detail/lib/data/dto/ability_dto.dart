import 'package:equatable/equatable.dart';
import 'package:poke_detail/data/dto/translation_dto.dart';

class AbilityDto extends Equatable {
  final String name;
  final String? url;
  final List<TranslationDto>? translations;

  AbilityDto(this.name, this.url, this.translations);

  AbilityDto copyWith({
    String? name,
    String? url,
    List<TranslationDto>? translations,
  }) {
    return AbilityDto(
      name ?? this.name,
      url ?? this.url,
      translations ?? this.translations,
    );
  }

  static AbilityDto fromJson(Map<String, dynamic> json) {
    return AbilityDto(
      json['name'] as String,
      json['url'] as String?,
      (json['names'] as List<dynamic>?)?.map((e) => TranslationDto.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['name'] = name;
    json['url'] = url;
    if (translations != null) {
      json['translations'] = translations!.map((e) => e.toJson()).toList();
    }
    return json;
  }

  @override
  List<Object?> get props => [name, url, translations];
}
