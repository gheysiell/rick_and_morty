import 'package:rick_and_morty/core/enums.dart';
import 'package:rick_and_morty/features/characters/domain/entities/characters_entity.dart';

class CharacterResponse {
  List<Character> characters;
  ResponseStatus responseStatus;
  bool hasNextPage;

  CharacterResponse({
    required this.characters,
    required this.responseStatus,
    required this.hasNextPage,
  });
}
