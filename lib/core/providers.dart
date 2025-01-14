import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:rick_and_morty/features/characters/data/datasources/remote/characters_datasource_remote_http.dart';
import 'package:rick_and_morty/features/characters/data/repositories/characters_repository_impl.dart';
import 'package:rick_and_morty/features/characters/domain/usecases/characters_usecase.dart';
import 'package:rick_and_morty/features/characters/presentation/viewmodels/characters_viewmodel.dart';
import 'package:rick_and_morty/features/characters_details/presentation/viewmodels/characters_details_viewmodel.dart';

List<SingleChildWidget> providers = [
  Provider(
    create: (context) => CharactersDataSourceRemoteHttpImpl(),
  ),
  Provider(
    create: (context) => CharactersRepositoryImpl(
      charactersDataSourceRemoteHttp: context.read<CharactersDataSourceRemoteHttpImpl>(),
    ),
  ),
  Provider(
    create: (context) => CharactersUseCase(
      charactersRepository: context.read<CharactersRepositoryImpl>(),
    ),
  ),
  ChangeNotifierProvider(
    create: (context) => CharactersViewModel(
      charactersUseCase: context.read<CharactersUseCase>(),
    ),
  ),
  ChangeNotifierProvider(
    create: (context) => CharactersDetailsViewModel(),
  ),
];
