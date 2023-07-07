import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miselaneos_app/config/plugins/share_plugins.dart';
import 'package:miselaneos_app/presentation/providers/pokemons/pokemon_provider.dart';

import '../../../domain/entities/pokemon.dart';

class PokemonScreen extends ConsumerWidget {
  final String pokemonId;
  const PokemonScreen({Key? key, required this.pokemonId}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final pokemonAsync = ref.watch(pokemonProvider(pokemonId));
    return pokemonAsync.when(
      data: (data) => _PokemonView(pokemon: data),
      error: (e, s) => _ErrorView(errorMessage: e.toString()),
      loading: () => _LoadingView(),
    );
  }
}

class _PokemonView extends StatelessWidget {
  final Pokemon pokemon;
  const _PokemonView({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name),
        actions: [
          IconButton(
            onPressed: () {
              SharePlugin.shareLink(
                "https://flutterdeeplinkingwebsite-production.up.railway.app/pokemons/${pokemon.id}/",
                "Mira este pokemon",
              );
            },
            icon: const Icon(Icons.share_rounded),
          )
        ],
      ),
      body: Center(
        child: Image.network(pokemon.spriteFront),
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String errorMessage;
  const _ErrorView({required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(errorMessage),
      ),
    );
  }
}
