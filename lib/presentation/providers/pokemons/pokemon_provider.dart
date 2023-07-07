import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miselaneos_app/domain/domain.dart';
import 'package:miselaneos_app/infrastructure/repositories/pokemon_repository_impl.dart';

final pokemonRepositoryprovider = Provider<PokemonRepository>((ref) {
  return PokemonsRepositoryImp();
});
final pokemonProvider = FutureProvider.family<Pokemon, String>((ref, id) async {
  final pokemonRepository = ref.watch(pokemonRepositoryprovider);
  final (pokemon, error) = await pokemonRepository.getPokemon(id);
  if (pokemon != null) return pokemon;
  throw error;
});
