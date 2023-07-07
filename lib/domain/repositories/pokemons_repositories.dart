import 'package:miselaneos_app/domain/entities/pokemon.dart';

abstract class PokemonRepository {
  Future<(Pokemon?, String)> getPokemon(String id);
}
