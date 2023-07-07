import 'package:go_router/go_router.dart';
import 'package:miselaneos_app/presentation/screens/biometrics/boimetric_screen.dart';
import 'package:miselaneos_app/presentation/screens/pokemons/pokemons_screen.dart';
import 'package:miselaneos_app/presentation/screens/screens.dart';

import '../../presentation/screens/pokemons/pokemon_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: "/permissions",
      builder: (context, state) => const PermissionsScreen(),
    ),
    GoRoute(
      path: "/gyroscope",
      builder: (context, state) => const GyrosScopeScreen(),
    ),
    GoRoute(
      path: "/accelerometer",
      builder: (context, state) => const AcelerometerScreen(),
    ),
    GoRoute(
      path: "/magnetometer",
      builder: (context, state) => const MagnetometerScreen(),
    ),
    GoRoute(
      path: "/gyroscope-ball",
      builder: (context, state) => const GyroScopeBallScreen(),
    ),
    GoRoute(
      path: "/compass",
      builder: (context, state) => const CompassScreen(),
    ),
    GoRoute(
      path: "/biometrics",
      builder: (context, state) => const BiometricScreen(),
    ),
    GoRoute(
      path: "/pokemons",
      builder: (context, state) => const PokemonsScreen(),
      routes: [
        GoRoute(
            path: ":id",
            builder: (context, state) {
              final id = state.pathParameters["id"] ?? '1';
              return PokemonScreen(pokemonId: id);
            }),
      ],
    ),
  ],
);
