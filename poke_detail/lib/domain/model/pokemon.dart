import 'package:equatable/equatable.dart';
import 'package:poke_detail/data/dto/pokemon_dto.dart';
import 'package:poke_detail/domain/model/Ability.dart';
import 'package:poke_detail/domain/model/Move.dart';

class Pokemon extends Equatable {
  final int id;
  final String name;
  final String image;
  final String imageHD;
  final List<Ability> abilities;
  final List<Move> moves;

  const Pokemon({
    required this.id,
    required this.name,
    required this.image,
    required this.imageHD,
    required this.abilities,
    required this.moves,
  });

  factory Pokemon.fromDto(PokemonDto dto) {
    return Pokemon(
      id: dto.id,
      name: dto.name,
      image: dto.image,
      imageHD: dto.imageHD,
      abilities: dto.abilities.map((e) => Ability.fromDto(e)).toList(),
      moves: dto.moves.map((e) => Move.fromDto(e)).toList(),
    );
  }

  Pokemon copyWith({
    int? id,
    String? name,
    String? image,
    String? imageHD,
    List<Ability>? abilities,
    List<Move>? moves,
  }) {
    return Pokemon(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      imageHD: imageHD ?? this.imageHD,
      abilities: abilities ?? this.abilities,
      moves: moves ?? this.moves,
    );
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
