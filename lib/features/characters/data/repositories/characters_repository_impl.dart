import 'package:rick_and_morty/core/enums.dart';
import 'package:rick_and_morty/features/characters/data/datasources/remote/characters_datasource_remote_http.dart';
import 'package:rick_and_morty/features/characters/data/dtos/characters_response_dto.dart';
import 'package:rick_and_morty/features/characters/domain/entities/characters_response_entity.dart';
import 'package:rick_and_morty/features/characters/domain/repositories/characters_repository.dart';
import 'package:rick_and_morty/utils/functions.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  CharactersDataSourceRemoteHttp charactersDataSourceRemoteHttp;

  CharactersRepositoryImpl({
    required this.charactersDataSourceRemoteHttp,
  });

  @override
  Future<CharacterResponse> getCharacters(String search, int page) async {
    if (!await Functions.checkConn()) {
      return CharacterResponse(
        characters: [],
        responseStatus: ResponseStatus.noConnection,
        hasNextPage: false,
      );
    }

    CharacterResponseDto characterResponseDto = await charactersDataSourceRemoteHttp.getCharacters(search, page);

    return characterResponseDto.toEntity();
  }
}
