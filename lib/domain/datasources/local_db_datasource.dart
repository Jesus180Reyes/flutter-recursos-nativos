import '../entities/pokemon.dart';

abstract class LocalDBDatasource {
  Future<List<Pokemon>> localPokemon();
  Future<int> pokemonCount();
  Future<void> insertPokemon(Pokemon pokemon);
}
