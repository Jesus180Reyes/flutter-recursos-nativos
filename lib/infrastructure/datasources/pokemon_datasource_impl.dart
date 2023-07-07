import 'package:dio/dio.dart';
import 'package:miselaneos_app/domain/datasources/pokemon_datasources.dart';
import 'package:miselaneos_app/domain/entities/pokemon.dart';
import 'package:miselaneos_app/infrastructure/mappers/pokemon_mapper.dart';

class PokemonsDatasourcesImpl implements PokemonDatasource {
  final dio = Dio(BaseOptions(baseUrl: "https://pokeapi.co/api/v2"));

  @override
  Future<(Pokemon?, String)> getPokemon(String id) async {
    // try {
    final resp = await dio.get("https://pokeapi.co/api/v2/pokemon/$id");
    final data = await resp.data;
    final pokemon = PokemonMapper.pokeApiPokemonToEntity(data);
    return (pokemon, "Data obtenido correctamente");
    // } catch (e) {
    //   return (
    //     Pokemon(
    //       id: 1,
    //       name: "ditto",
    //       spriteFront:
    //           "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/132.png",
    //     ),
    //     "No se pudo obtener el pokemon: $e"
    //   );
    // }
  }
}
