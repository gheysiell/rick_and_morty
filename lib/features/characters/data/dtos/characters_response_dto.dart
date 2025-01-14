import 'package:rick_and_morty/core/enums.dart';
import 'package:rick_and_morty/features/characters/data/dtos/characters_dto.dart';
import 'package:rick_and_morty/features/characters/domain/entities/characters_response_entity.dart';

class CharacterResponseDto {
  List<CharacterDto> charactersDto;
  ResponseStatus responseStatus;
  bool hasNextPage;

  CharacterResponseDto({
    required this.charactersDto,
    required this.responseStatus,
    required this.hasNextPage,
  });

  CharacterResponse toEntity() {
    return CharacterResponse(
      characters: charactersDto.map((characterDto) => characterDto.toEntity()).toList(),
      responseStatus: responseStatus,
      hasNextPage: hasNextPage,
    );
  }
}
