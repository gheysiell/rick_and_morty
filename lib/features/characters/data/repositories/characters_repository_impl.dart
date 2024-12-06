import 'package:rick_and_morty/features/characters/data/datasources/remote/characters_datasource_remote_http.dart';
import 'package:rick_and_morty/features/characters/data/dtos/characters_dto.dart';
import 'package:rick_and_morty/features/characters/domain/entities/characters_entity.dart';
import 'package:rick_and_morty/features/characters/domain/repositories/characters_repository.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  CharactersDataSourceRemoteHttpImpl charactersDataSourceRemoteHttpImpl;

  CharactersRepositoryImpl({
    required this.charactersDataSourceRemoteHttpImpl,
  });

  @override
  Future<List<Character>> getCharacters() async {
    List<CharacterDto> characters = await charactersDataSourceRemoteHttpImpl.getCharacters();

    return characters.map((character) => character.toEntity()).toList();
  }
}
