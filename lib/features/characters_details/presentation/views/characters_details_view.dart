import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/core/models/title_and_info.dart';
import 'package:rick_and_morty/features/characters/domain/entities/characters_entity.dart';
import 'package:rick_and_morty/features/characters_details/presentation/viewmodels/characters_details_viewmodel.dart';
import 'package:rick_and_morty/shared/palette.dart';
import 'package:rick_and_morty/shared/text_styles.dart';
import 'package:rick_and_morty/utils/functions.dart';

class CharactersDetailsView extends StatefulWidget {
  final Character character;

  const CharactersDetailsView({
    super.key,
    required this.character,
  });

  @override
  State<CharactersDetailsView> createState() {
    return CharactersDetailsViewState();
  }
}

class CharactersDetailsViewState extends State<CharactersDetailsView> {
  late CharactersDetailsViewModel charactersDetailsViewModel;
  List<TitleAndInfo> titlesAndInfos = [];
  bool initialized = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!initialized) {
      charactersDetailsViewModel = context.watch<CharactersDetailsViewModel>();

      WidgetsBinding.instance.addPostFrameCallback((_) {
        charactersDetailsViewModel.setCharacter(widget.character);

        titlesAndInfos = [
          TitleAndInfo(
            title: 'ID',
            info: charactersDetailsViewModel.character!.id.toString(),
          ),
          TitleAndInfo(
            title: 'Nome',
            info: charactersDetailsViewModel.character!.name,
          ),
          TitleAndInfo(
            title: 'Status',
            info: charactersDetailsViewModel.character!.status,
          ),
          TitleAndInfo(
            title: 'Specie',
            info: charactersDetailsViewModel.character!.species,
          ),
          TitleAndInfo(
            title: 'Tipo',
            info: charactersDetailsViewModel.character!.type,
          ),
          TitleAndInfo(
            title: 'Gênero',
            info: charactersDetailsViewModel.character!.gender,
          ),
          TitleAndInfo(
            title: 'Criado',
            info: charactersDetailsViewModel.character!.created,
          ),
        ];
      });

      initialized = true;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Character',
          style: TextStyles.textStyleAppBar,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            size: 30,
            color: Palette.gray,
          ),
          tooltip: 'Voltar',
        ),
        backgroundColor: Palette.white,
        surfaceTintColor: Palette.white,
      ),
      backgroundColor: Palette.white,
      body: charactersDetailsViewModel.character == null
          ? const SizedBox()
          : ListView.builder(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
              itemCount: titlesAndInfos.length,
              itemBuilder: (context, index) {
                int indexTitlesAndInfos = index - 1;

                return index == 0
                    ? Container(
                        height: 250,
                        margin: const EdgeInsets.only(
                          top: 10,
                          bottom: 20,
                        ),
                        child: TextButton(
                          onPressed: () {
                            Functions.showNetworkImageFullScreen(
                                context, charactersDetailsViewModel.character!.imageUrl);
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: charactersDetailsViewModel.character!.imageUrl,
                            imageBuilder: (context, imageProvider) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image(
                                  image: imageProvider,
                                ),
                              );
                            },
                            placeholder: (context, url) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                            errorWidget: (context, url, error) {
                              return const Icon(
                                Icons.person,
                                size: 200,
                                color: Palette.grayExtraLight,
                              );
                            },
                          ),
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Functions.isPair(indexTitlesAndInfos) ? Palette.creamy : Palette.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Text(
                                titlesAndInfos[indexTitlesAndInfos].title,
                                style: const TextStyle(
                                  fontSize: 17,
                                  color: Palette.gray,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: Text(
                                titlesAndInfos[indexTitlesAndInfos].info,
                                style: const TextStyle(
                                  fontSize: 17,
                                  color: Palette.gray,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
              },
            ),
    );
  }
}
