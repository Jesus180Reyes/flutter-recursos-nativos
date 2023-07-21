import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miselaneos_app/config/workmanager/callback_dispatcher.dart';
import 'package:miselaneos_app/domain/domain.dart';
import 'package:miselaneos_app/presentation/providers/background_tasks/background_tasks_provider.dart';
import 'package:miselaneos_app/presentation/providers/pokemons/pokemon_db_provder.dart';
import 'package:workmanager/workmanager.dart';

class DbPokemonsScreen extends ConsumerWidget {
  const DbPokemonsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final pokemonAsync = ref.watch(pokemonDbProvider);
    if (pokemonAsync.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    }
    final List<Pokemon> pokemons = pokemonAsync.value ?? [];
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ref.read(backgroundPokemonFetchProvider.notifier).activateTask();
        },
        label: const Text("Activar fetch periodico"),
        icon: const Icon(Icons.av_timer),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Workmanager().registerOneOffTask(
                fetchBackgroundTaskKey,
                fetchBackgroundTaskKey,
                initialDelay: const Duration(seconds: 3),
                inputData: {"howMany": 30},
              );
            },
            icon: const Icon(
              Icons.add_alarm_rounded,
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          PokemonGrid(
            pokemons: pokemons,
          ),
        ],
      ),
    );
  }
}

class PokemonGrid extends StatelessWidget {
  final List<Pokemon> pokemons;
  const PokemonGrid({super.key, required this.pokemons});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemBuilder: (context, index) {
        final pokemon = pokemons[index];
        return Column(
          children: [
            Image.network(
              pokemon.spriteFront,
              fit: BoxFit.contain,
            ),
            Text(pokemon.name),
          ],
        );
      },
      itemCount: pokemons.length,
    );
  }
}
