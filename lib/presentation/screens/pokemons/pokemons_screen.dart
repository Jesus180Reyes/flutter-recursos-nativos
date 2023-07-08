import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:miselaneos_app/presentation/providers/local_auth/local_auth_providers.dart';
import 'package:miselaneos_app/presentation/providers/pokemons/pokemon_list_provider.dart';
import 'package:miselaneos_app/presentation/screens/biometrics/boimetric_screen.dart';

class PokemonsScreen extends ConsumerWidget {
  const PokemonsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final localAuth = ref.watch(localAuthNotifier);
    if (!localAuth.didAuthenticated) return const BiometricScreen();
    return const Scaffold(
      body: PokemonView(),
    );
  }
}

class PokemonView extends ConsumerStatefulWidget {
  const PokemonView({super.key});

  @override
  PokemonViewState createState() => PokemonViewState();
}

class PokemonViewState extends ConsumerState<PokemonView> {
  final scrollController = ScrollController();

  void infiniteScroll() {
    final currentPokemons = ref.read(pokemonsIdsProvider);
    if (currentPokemons.length > 400) {
      scrollController.removeListener(infiniteScroll);
      return;
    }
    if ((scrollController.position.pixels + 200) >
        scrollController.position.maxScrollExtent) {
      ref.read(pokemonsIdsProvider.notifier).update(
            (state) => [
              ...state,
              ...List.generate(30, (index) => state.length + index + 1),
            ],
          );
    }
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(infiniteScroll);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverAppBar(
          title: const Text("Pokemons"),
          floating: true,
          backgroundColor: Colors.white.withOpacity(0.8),
        ),
        const _PokemonGrid()
      ],
    );
  }
}

class _PokemonGrid extends ConsumerWidget {
  const _PokemonGrid();

  @override
  Widget build(BuildContext context, ref) {
    final pokemonIds = ref.watch(pokemonsIdsProvider);
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        childAspectRatio: 1,
      ),
      itemCount: pokemonIds.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => context.push("/pokemons/${index + 1}"),
          child: Image.network(
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${index + 1}.png",
            fit: BoxFit.contain,
          ),
        );
      },
    );
  }
}
