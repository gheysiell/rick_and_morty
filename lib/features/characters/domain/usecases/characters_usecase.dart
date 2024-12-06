import 'package:rick_and_morty/features/characters/domain/entities/characters_entity.dart';
import 'package:rick_and_morty/features/characters/domain/repositories/characters_repository.dart';

class CharactersUseCase {
  CharactersRepository charactersRepository;

  CharactersUseCase({
    required this.charactersRepository,
  });

  Future<List<Character>> getCharacters() async {
    return await charactersRepository.getCharacters();
  }
}
