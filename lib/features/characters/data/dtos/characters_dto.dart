import 'package:rick_and_morty/features/characters/domain/entities/characters_entity.dart';

class CharacterDto {
  int id;
  String name, status, species, type, gender, image, created;

  CharacterDto({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.image,
    required this.created,
  });

  factory CharacterDto.fromMap(Map<String, dynamic> map) {
    return CharacterDto(
      id: map['id'],
      name: map['name'],
      status: map['status'],
      species: map['species'],
      type: map['type'],
      gender: map['gender'],
      image: map['image'],
      created: map['created'],
    );
  }

  factory CharacterDto.fromEntity(Character character) {
    return CharacterDto(
      id: character.id,
      name: character.name,
      status: character.status,
      species: character.species,
      type: character.type,
      gender: character.gender,
      image: character.image,
      created: character.created,
    );
  }

  Character toEntity() {
    return Character(
      id: id,
      name: name,
      status: status,
      species: species,
      type: type,
      gender: gender,
      image: image,
      created: created,
    );
  }
}
