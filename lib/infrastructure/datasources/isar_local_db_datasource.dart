import 'package:isar/isar.dart';
import 'package:miselaneos_app/domain/datasources/local_db_datasource.dart';
import 'package:miselaneos_app/domain/entities/pokemon.dart';
import 'package:path_provider/path_provider.dart';

class IsarLocalDbDatasource extends LocalDBDatasource {
  late Future<Isar> db;

  IsarLocalDbDatasource() {
    db = openDB();
  }
  @override
  Future<void> insertPokemon(Pokemon pokemon) async {
    final isar = await db;
    isar.writeTxnSync(() => isar.pokemons.putSync(pokemon));
  }

  @override
  Future<List<Pokemon>> localPokemon() async {
    final isar = await db;
    return isar.pokemons.where().findAll();
  }

  @override
  Future<int> pokemonCount() async {
    final isar = await db;
    return isar.pokemons.count();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([PokemonSchema],
          directory: dir.path, inspector: true);
    }
    return Future.value(Isar.getInstance());
  }
}
