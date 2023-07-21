import 'package:miselaneos_app/domain/datasources/local_db_datasource.dart';
import 'package:miselaneos_app/domain/entities/pokemon.dart';
import 'package:miselaneos_app/domain/repositories/local_db_repositorie.dart';
import 'package:miselaneos_app/infrastructure/datasources/isar_local_db_datasource.dart';

class LocalDbRespositorieImplementation extends LocalDBRepository {
  final LocalDBDatasource _datasource;

  LocalDbRespositorieImplementation([LocalDBDatasource? datasource])
      : _datasource = datasource ?? IsarLocalDbDatasource();
  @override
  Future<void> insertPokemon(Pokemon pokemon) {
    return _datasource.insertPokemon(pokemon);
  }

  @override
  Future<List<Pokemon>> localPokemon() {
    return _datasource.localPokemon();
  }

  @override
  Future<int> pokemonCount() {
    return _datasource.pokemonCount();
  }
}
