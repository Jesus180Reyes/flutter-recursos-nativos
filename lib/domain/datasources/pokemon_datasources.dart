import 'package:miselaneos_app/domain/entities/pokemon.dart';

abstract class PokemonDatasource {
  Future<(Pokemon?, String)> getPokemon(String id);
}
