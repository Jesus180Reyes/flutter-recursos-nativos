import 'package:miselaneos_app/infrastructure/repositories/local_db_repositorie_impl.dart';
import 'package:miselaneos_app/infrastructure/repositories/pokemon_repository_impl.dart';
import 'package:workmanager/workmanager.dart';

const fetchBackgroundTaskKey =
    "com.jesusreyes.miselaneos.fetch-background-pokemon";
const fetchPeriodicBackgroundTaskKey =
    "com.jesusreyes.miselaneos.fetch-background-pokemon";
// Mandatory if the App is obfuscated or using Flutter 3.1+
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case fetchBackgroundTaskKey:
        await loadNextPokemon();

        break;
      // ignore: unreachable_switch_case
      case fetchPeriodicBackgroundTaskKey:
        await loadNextPokemon();

        break;
      case Workmanager.iOSBackgroundTask:
        break;
    }
    return true;
    // print(
    //     "Native::  called background task: $task"); //simpleTask will be emitted here.
    // return Future.value(true);
  });
}

Future getPokemons() async {}

Future loadNextPokemon() async {
  final localRepository = LocalDbRespositorieImplementation();
  final pokemonRepository = PokemonsRepositoryImp();
  final lastPokemonId = await localRepository.pokemonCount() + 1;

  try {
    final (pokemon, message) =
        await pokemonRepository.getPokemon("$lastPokemonId");
    if (pokemon == null) throw message;
    await localRepository.insertPokemon(pokemon);
  } catch (e) {
    Future.error(e);
  }
}
