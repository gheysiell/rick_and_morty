import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/features/characters/presentation/viewmodels/characters_viewmodel.dart';

class CharactersView extends StatefulWidget {
  const CharactersView({super.key});

  @override
  State<CharactersView> createState() {
    return CharactersViewState();
  }
}

class CharactersViewState extends State<CharactersView> {
  bool initialized = false;
  late CharactersViewModel charactersViewModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!initialized) {
      charactersViewModel = context.watch<CharactersViewModel>();

      charactersViewModel.getCharacters();

      initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Personagens',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.purple[300],
      ),
      body: RefreshIndicator(
        child: ListView.builder(
          itemCount: charactersViewModel.characters.length,
          itemBuilder: (BuildContext context, int index) => ListTile(
            title: Text(charactersViewModel.characters[index].name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                )),
            subtitle: Text(
              charactersViewModel.characters[index].status,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            leading: SizedBox(
              width: 80,
              height: double.infinity,
              child: Image(
                image: NetworkImage(
                  charactersViewModel.characters[index].image,
                ),
              ),
            ),
          ),
        ),
        onRefresh: () async {
          await charactersViewModel.getCharacters();
        },
      ),
    );
  }
}
