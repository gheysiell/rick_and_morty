import 'package:rick_and_morty/features/characters/domain/entities/characters_entity.dart';
import 'package:rick_and_morty/utils/format_functions.dart';

class CharacterDto {
  int id;
  String name, status, species, type, gender, imageUrl, created;

  CharacterDto({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.imageUrl,
    required this.created,
  });

  factory CharacterDto.fromMap(Map<String, dynamic> map) {
    return CharacterDto(
      id: FormatFunctions.safeParseInt(map['id']),
      name: FormatFunctions.safeParseString(map['name']),
      status: FormatFunctions.safeParseString(map['status']),
      species: FormatFunctions.safeParseString(map['species']),
      type: FormatFunctions.safeParseString(map['type']),
      gender: FormatFunctions.safeParseString(map['gender']),
      imageUrl: FormatFunctions.safeParseString(map['image']),
      created: FormatFunctions.safeParseString(map['created']),
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
      imageUrl: imageUrl,
      created: created,
    );
  }
}
