import 'package:flutter/material.dart';
import 'package:rick_and_morty/features/characters/domain/entities/characters_entity.dart';
import 'package:rick_and_morty/features/characters/domain/usecases/characters_usecase.dart';

class CharactersViewModel extends ChangeNotifier {
  final CharactersUseCase charactersUseCase;
  List<Character> characters = [];

  CharactersViewModel({
    required this.charactersUseCase,
  });

  void setCharacters(List<Character> value) {
    characters = value;
    notifyListeners();
  }

  Future<void> getCharacters() async {
    List<Character> characters = await charactersUseCase.getCharacters();
    setCharacters(characters);
  }
}
