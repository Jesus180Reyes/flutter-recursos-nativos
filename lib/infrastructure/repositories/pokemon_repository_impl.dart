import 'package:miselaneos_app/domain/domain.dart';
import 'package:miselaneos_app/infrastructure/datasources/pokemon_datasource_impl.dart';

class PokemonsRepositoryImp implements PokemonRepository {
  final PokemonDatasource datasource;

  PokemonsRepositoryImp({PokemonDatasource? datasource})
      : datasource = datasource ?? PokemonsDatasourcesImpl();
  @override
  Future<(Pokemon?, String)> getPokemon(String id) async {
    return datasource.getPokemon(id);
  }
}
