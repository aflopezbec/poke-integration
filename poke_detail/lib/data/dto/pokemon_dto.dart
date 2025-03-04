import 'package:equatable/equatable.dart';
import 'package:poke_detail/data/dto/ability_dto.dart';
import 'package:poke_detail/data/dto/move_dto.dart';

class PokemonDto extends Equatable {
  final int id;
  final String name;
  final String image;
  final String imageHD;
  final List<AbilityDto> abilities;
  final List<MoveDto> moves;

  const PokemonDto({
    required this.id,
    required this.name,
    required this.image,
    required this.imageHD,
    required this.abilities,
    required this.moves,
  });

  factory PokemonDto.fromJson(Map<String, dynamic> json) {
    return PokemonDto(
      id: json['id'],
      name: json['name'],
      image: json['sprites']['front_default'] ?? '',
      imageHD:
          "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${json['id']}.png", //
      abilities: (json['abilities'] as List).map((a) => AbilityDto.fromJson(a['ability'])).toList(),
      moves: (json['moves'] as List).map((m) => MoveDto.fromJson(m['move'])).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'imageHD': imageHD,
      'abilities': abilities.map((a) => a.toJson()).toList(),
      'moves': moves.map((m) => m.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        image,
        imageHD,
        abilities,
        moves,
      ];
}
