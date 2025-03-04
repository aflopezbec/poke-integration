import 'package:equatable/equatable.dart';

class TranslationDto extends Equatable {
  final String name;
  final LanguageDto language;

  const TranslationDto(this.name, this.language);

  static TranslationDto fromJson(Map<String, dynamic> json) {
    return TranslationDto(json["name"], LanguageDto.fromJson(json["language"]));
  }

  Map<String, dynamic> toJson() {
    return {"name": name, "language": language.toJson()};
  }

  @override
  List<Object?> get props => [name, language];
}

class LanguageDto extends Equatable {
  final String name;
  final String url;

  const LanguageDto(this.name, this.url);

  static LanguageDto fromJson(Map<String, dynamic> json) {
    return LanguageDto(json["name"], json["url"]);
  }

  Map<String, dynamic> toJson() {
    return {"name": name, "url": url};
  }

  @override
  List<Object?> get props => [name, url];
}
