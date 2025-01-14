import 'package:flutter/material.dart';
import 'package:rick_and_morty/features/characters/domain/entities/characters_entity.dart';

class CharactersDetailsViewModel extends ChangeNotifier {
  Character? character;

  void setCharacter(Character value) {
    character = value;
    notifyListeners();
  }
}
