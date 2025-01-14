import 'package:rick_and_morty/features/characters/domain/entities/characters_response_entity.dart';
import 'package:rick_and_morty/features/characters/domain/repositories/characters_repository.dart';

class CharactersUseCase {
  CharactersRepository charactersRepository;

  CharactersUseCase({
    required this.charactersRepository,
  });

  Future<CharacterResponse> getCharacters(
    String search,
    int page,
  ) async {
    return await charactersRepository.getCharacters(search, page);
  }
}
