import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:rick_and_morty/core/constants/constants.dart';
import 'package:rick_and_morty/features/characters/data/dtos/characters_dto.dart';
import 'package:http/http.dart' as http;

abstract class CharactersDataSourceRemoteHttp {
  Future<List<CharacterDto>> getCharacters();
}

class CharactersDataSourceRemoteHttpImpl implements CharactersDataSourceRemoteHttp {
  @override
  Future<List<CharacterDto>> getCharacters() async {
    List<CharacterDto> characters = [];

    try {
      final response = await http.get(Uri.parse('${Constants.apiUrl}character'));

      if (response.statusCode != 200) {
        throw Exception();
      }

      List charactersResponse = json.decode(response.body)['results'];

      characters = charactersResponse.map((character) => CharacterDto.fromMap(character)).toList();
    } on TimeoutException {
      log('timeout exception in CharactersDataSourceRemoteHttp.getCharacters');
    } catch (e) {
      log(
        'generic exception in CharactersDataSourceRemoteHttp.getCharacters',
        error: e,
      );
    }

    return characters;
  }
}
