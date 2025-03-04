import 'package:equatable/equatable.dart';
import 'package:poke_detail/data/dto/translation_dto.dart';

class MoveDto extends Equatable {
  final String name;
  final String? url;
  final List<TranslationDto>? translations;

  MoveDto(this.name, this.url, this.translations);

  static MoveDto fromJson(Map<String, dynamic> json) {
    return MoveDto(
      json["name"] as String,
      json["url"] as String?,
      (json['names'] as List<dynamic>?)?.map((e) => TranslationDto.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "url": url,
      "translations": translations?.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [name, url, translations];
}
