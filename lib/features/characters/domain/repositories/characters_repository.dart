import 'package:rick_and_morty/features/characters/domain/entities/characters_response_entity.dart';

abstract class CharactersRepository {
  Future<CharacterResponse> getCharacters(String search, int page);
}
