import 'package:rick_and_morty/features/characters/domain/entities/characters_entity.dart';

abstract class CharactersRepository {
  Future<List<Character>> getCharacters();
}
