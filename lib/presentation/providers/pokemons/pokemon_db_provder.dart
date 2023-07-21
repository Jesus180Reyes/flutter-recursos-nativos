import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miselaneos_app/infrastructure/repositories/local_db_repositorie_impl.dart';

import '../../../domain/entities/pokemon.dart';

final pokemonDbProvider =
    FutureProvider.autoDispose<List<Pokemon>>((ref) async {
  final localDb = LocalDbRespositorieImplementation();
  final pokemon = await localDb.localPokemon();
  return pokemon;
});
