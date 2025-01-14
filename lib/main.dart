import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/core/navigation_service.dart';
import 'package:rick_and_morty/core/providers.dart';
import 'package:rick_and_morty/core/theme_data.dart';
import 'package:rick_and_morty/features/characters/presentation/views/characters_view.dart';

void main() {
  runApp(const RickAndMorty());
}

class RickAndMorty extends StatelessWidget {
  const RickAndMorty({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'Rick and Morty',
        debugShowCheckedModeBanner: false,
        navigatorKey: NavigationService.navigatorKey,
        theme: buildTheme(),
        home: const CharactersView(),
      ),
    );
  }
}
