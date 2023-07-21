import '../entities/pokemon.dart';

abstract class LocalDBRepository {
  Future<List<Pokemon>> localPokemon();
  Future<int> pokemonCount();
  Future<void> insertPokemon(Pokemon pokemon);
}
