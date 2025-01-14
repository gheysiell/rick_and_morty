import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:rick_and_morty/core/constants.dart';
import 'package:rick_and_morty/core/enums.dart';
import 'package:rick_and_morty/features/characters/data/dtos/characters_dto.dart';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty/features/characters/data/dtos/characters_response_dto.dart';

abstract class CharactersDataSourceRemoteHttp {
  Future<CharacterResponseDto> getCharacters(String search, int page);
}

class CharactersDataSourceRemoteHttpImpl implements CharactersDataSourceRemoteHttp {
  @override
  Future<CharacterResponseDto> getCharacters(String search, int page) async {
    final CharacterResponseDto characterResponseDto = CharacterResponseDto(
      charactersDto: [],
      responseStatus: ResponseStatus.success,
      hasNextPage: false,
    );
    final Uri uri = Uri.parse('${Constants.apiUrl}character?name=$search&page=$page');

    try {
      final response = await http.get(uri).timeout(Constants.timeoutDurationRemoteHttp);

      if (response.statusCode != 200) {
        log('${Constants.badRequestMessage} CharactersDataSourceRemoteHttp.getCharacters',
            error: 'statusCode: ${response.statusCode} | response: ${response.body}');
        throw Exception();
      }

      List charactersBody = json.decode(response.body)['results'];
      Map<String, dynamic> infosBody = json.decode(response.body)['info'];

      characterResponseDto.hasNextPage = infosBody['next'] != null;
      characterResponseDto.charactersDto = charactersBody.map((character) => CharacterDto.fromMap(character)).toList();
    } on TimeoutException {
      log('${Constants.timeoutExceptionMessage} CharactersDataSourceRemoteHttp.getCharacters');
      characterResponseDto.responseStatus = ResponseStatus.timeout;
    } catch (e) {
      log('${Constants.genericExceptionMessage} CharactersDataSourceRemoteHttp.getCharacters', error: e);
      characterResponseDto.responseStatus = ResponseStatus.error;
    }

    return characterResponseDto;
  }
}
