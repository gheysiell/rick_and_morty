import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/features/characters/data/datasources/remote/characters_datasource_remote_http.dart';
import 'package:rick_and_morty/features/characters/data/repositories/characters_repository_impl.dart';
import 'package:rick_and_morty/features/characters/domain/usecases/characters_usecase.dart';
import 'package:rick_and_morty/features/characters/presentation/viewmodels/characters_viewmodel.dart';
import 'package:rick_and_morty/features/characters/presentation/views/characters_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => CharactersDataSourceRemoteHttpImpl()),
        Provider(
            create: (context) => CharactersRepositoryImpl(
                charactersDataSourceRemoteHttpImpl: context.read<CharactersDataSourceRemoteHttpImpl>())),
        Provider(
            create: (context) => CharactersUseCase(charactersRepository: context.read<CharactersRepositoryImpl>())),
        ChangeNotifierProvider(
            create: (context) => CharactersViewModel(charactersUseCase: context.read<CharactersUseCase>())),
      ],
      child: MaterialApp(
        title: 'Rick and Morty',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const RickAndMorty(),
      ),
    );
  }
}

class RickAndMorty extends StatelessWidget {
  const RickAndMorty({super.key});

  @override
  Widget build(BuildContext context) {
    return const CharactersView();
  }
}
