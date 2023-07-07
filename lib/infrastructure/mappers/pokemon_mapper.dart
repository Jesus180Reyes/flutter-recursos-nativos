import 'package:miselaneos_app/domain/domain.dart';
import 'package:miselaneos_app/infrastructure/models/pokeapi_response.dart';

class PokemonMapper {
  static Pokemon pokeApiPokemonToEntity(Map<String, dynamic> json) {
    final pokeApiPokemon = PokeApiResponse.fromJson(json);

    return Pokemon(
      id: pokeApiPokemon.id,
      name: pokeApiPokemon.name,
      spriteFront: pokeApiPokemon.sprites.frontDefault,
    );
  }
}
