import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/features/characters/presentation/viewmodels/characters_viewmodel.dart';
import 'package:rick_and_morty/features/characters_details/presentation/views/characters_details_view.dart';
import 'package:rick_and_morty/shared/input_styles.dart';
import 'package:rick_and_morty/shared/palette.dart';
import 'package:rick_and_morty/shared/widgets/not_found.dart';
import 'package:rick_and_morty/utils/functions.dart';

class CharactersView extends StatefulWidget {
  const CharactersView({super.key});

  @override
  State<CharactersView> createState() {
    return CharactersViewState();
  }
}

class CharactersViewState extends State<CharactersView> {
  late CharactersViewModel charactersViewModel;
  final double heightAppBar = 150;
  final ScrollController scrollController = ScrollController();
  final TextEditingController controllerSearch = TextEditingController();
  final FocusNode focusSearch = FocusNode();
  bool initialized = false;

  int page = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!initialized) {
      charactersViewModel = context.watch<CharactersViewModel>();

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await charactersViewModel.getCharacters('', 1, false);
      });

      scrollController.addListener(() async {
        if (focusSearch.hasFocus) focusSearch.unfocus();

        if (!charactersViewModel.hasNextPage || charactersViewModel.pagining) return;

        final double currentPosition = scrollController.position.pixels;
        final double maxScrollPosition = scrollController.position.maxScrollExtent;

        if (currentPosition == maxScrollPosition) {
          page++;
          await charactersViewModel.getCharacters(controllerSearch.text, page, true);
        }
      });

      initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        focusSearch.unfocus();
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(heightAppBar),
          child: AppBar(
            title: const Text(
              'Rick and Morty',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Palette.gray,
              ),
            ),
            leadingWidth: 70,
            titleSpacing: 4,
            leading: Container(
              height: 60,
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/icon.png',
              ),
            ),
            backgroundColor: Palette.white,
            surfaceTintColor: Palette.white,
            elevation: 5,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 14,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 0,
                ),
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Palette.grayExtraLight,
                      blurRadius: 8,
                      spreadRadius: 1,
                    )
                  ],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextFormField(
                  controller: controllerSearch,
                  focusNode: focusSearch,
                  style: const TextStyle(
                    color: Palette.grayMedium,
                    fontSize: 20,
                    decoration: TextDecoration.none,
                  ),
                  textAlign: TextAlign.left,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    filled: true,
                    isDense: true,
                    fillColor: Palette.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 14,
                    ),
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      size: 30,
                      color: Palette.grayMedium,
                    ),
                    suffixIcon: charactersViewModel.searching
                        ? IconButton(
                            onPressed: () async {
                              page = 1;
                              controllerSearch.clear();
                              focusSearch.unfocus();
                              await charactersViewModel.getCharacters('', 1, false);
                            },
                            icon: const Icon(
                              Icons.clear_rounded,
                              size: 30,
                              color: Palette.grayMedium,
                            ),
                            tooltip: 'Limpar pesquisa',
                          )
                        : null,
                    label: controllerSearch.text.isEmpty && !focusSearch.hasFocus
                        ? const Text(
                            'Pesquisar',
                            style: TextStyle(
                              fontSize: 18,
                              color: Palette.grayMedium,
                            ),
                          )
                        : null,
                    border: InputStyles.borderSearch,
                    enabledBorder: InputStyles.borderSearch,
                    focusedBorder: InputStyles.borderSearch,
                  ),
                  onTap: () {
                    focusSearch.requestFocus();
                  },
                  onFieldSubmitted: (String value) async {
                    page = 1;
                    focusSearch.unfocus();
                    await charactersViewModel.getCharacters(controllerSearch.text, 1, false);
                  },
                ),
              ),
            ),
          ),
        ),
        backgroundColor: Palette.white,
        body: charactersViewModel.loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () async {
                  page = 1;
                  await charactersViewModel.getCharacters(controllerSearch.text, 1, false);
                },
                child: !charactersViewModel.loading && charactersViewModel.characters.isEmpty
                    ? NotFoundWidget(
                        title: 'Personagens não encontrados',
                        heightAppBar: heightAppBar + kToolbarHeight,
                      )
                    : Stack(
                        children: [
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    padding: const EdgeInsets.only(
                                      bottom: 10,
                                      top: 20,
                                    ),
                                    physics: const AlwaysScrollableScrollPhysics(),
                                    controller: scrollController,
                                    itemCount: charactersViewModel.characters.length + 1,
                                    itemBuilder: (BuildContext context, int index) {
                                      return index != (charactersViewModel.characters.length)
                                          ? ListTile(
                                              leading: SizedBox(
                                                width: 60,
                                                child: TextButton(
                                                  onPressed: () {
                                                    Functions.showNetworkImageFullScreen(
                                                        context, charactersViewModel.characters[index].imageUrl);
                                                  },
                                                  style: TextButton.styleFrom(
                                                    padding: EdgeInsets.zero,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(12),
                                                    ),
                                                  ),
                                                  child: CachedNetworkImage(
                                                    imageUrl: charactersViewModel.characters[index].imageUrl,
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
                                                        child: CircularProgressIndicator(
                                                          strokeWidth: 3,
                                                        ),
                                                      );
                                                    },
                                                    errorWidget: (context, url, error) {
                                                      return const Icon(
                                                        Icons.person,
                                                        size: 50,
                                                        color: Palette.grayExtraLight,
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                              title: Text(
                                                charactersViewModel.characters[index].name,
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Palette.grayMedium,
                                                ),
                                              ),
                                              subtitle: Text(
                                                charactersViewModel.characters[index].species,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Palette.grayMedium,
                                                ),
                                              ),
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => CharactersDetailsView(
                                                      character: charactersViewModel.characters[index],
                                                    ),
                                                  ),
                                                );
                                              },
                                            )
                                          : charactersViewModel.hasNextPage
                                              ? const SizedBox(
                                                  height: 60,
                                                  child: Center(
                                                    child: CircularProgressIndicator(),
                                                  ),
                                                )
                                              : const SizedBox();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Palette.white,
                                    Palette.white.withOpacity(0.9),
                                    Palette.white.withOpacity(0.7),
                                    Palette.white.withOpacity(0.6),
                                    Palette.white.withOpacity(0.4),
                                    Palette.white.withOpacity(0.2),
                                    Palette.white.withOpacity(0),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
      ),
    );
  }
}
