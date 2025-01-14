import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/enums.dart';
import 'package:rick_and_morty/features/characters/domain/entities/characters_entity.dart';
import 'package:rick_and_morty/features/characters/domain/entities/characters_response_entity.dart';
import 'package:rick_and_morty/features/characters/domain/usecases/characters_usecase.dart';
import 'package:rick_and_morty/utils/functions.dart';

class CharactersViewModel extends ChangeNotifier {
  List<Character> characters = [];
  bool loading = false;
  bool searching = false;
  bool pagining = false;
  bool hasNextPage = false;
  CharactersUseCase charactersUseCase;

  CharactersViewModel({
    required this.charactersUseCase,
  });

  void setCharacters(List<Character> value) {
    characters = value;
    notifyListeners();
  }

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  void setSearching(bool value) {
    searching = value;
    notifyListeners();
  }

  void setPagining(bool value) {
    pagining = value;
    notifyListeners();
  }

  void setHasNextPage(bool value) {
    hasNextPage = value;
    notifyListeners();
  }

  Future<void> getCharacters(
    String search,
    int page,
    bool isPagination,
  ) async {
    setSearching(search.isNotEmpty);

    if (!isPagination) {
      setLoading(true);
    } else {
      setPagining(true);
    }

    CharacterResponse characterResponse = await charactersUseCase.getCharacters(search, page);

    if (!isPagination) {
      setLoading(false);
    } else {
      setPagining(false);
    }

    setCharacters(isPagination ? characters + characterResponse.characters : characterResponse.characters);
    setHasNextPage(characterResponse.hasNextPage);

    if (characterResponse.responseStatus != ResponseStatus.success) {
      Functions.showMessageResponseStatus(
        characterResponse.responseStatus,
        'buscar',
        'os',
        'personagens',
      );
    }
  }
}
