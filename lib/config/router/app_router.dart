import 'package:go_router/go_router.dart';
import 'package:miselaneos_app/presentation/screens/ads/ads_rewarded_screen.dart';
import 'package:miselaneos_app/presentation/screens/ads/ads_screen.dart';
import 'package:miselaneos_app/presentation/screens/badge/badge_screen.dart';
import 'package:miselaneos_app/presentation/screens/biometrics/boimetric_screen.dart';
import 'package:miselaneos_app/presentation/screens/location/controlled_map_screen.dart';
import 'package:miselaneos_app/presentation/screens/location/location_screen.dart';
import 'package:miselaneos_app/presentation/screens/location/map_screen.dart';
import 'package:miselaneos_app/presentation/screens/pokemons/db_pokemons_screen.dart';
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
    GoRoute(
      path: "/location",
      builder: (context, state) => const LocationScreen(),
    ),
    GoRoute(
      path: "/maps",
      builder: (context, state) => const MapScreen(),
    ),
    GoRoute(
      path: "/controlled-map",
      builder: (context, state) => const ControlledMapScreen(),
    ),
    GoRoute(
      path: "/badge",
      builder: (context, state) => const BadgeScreen(),
    ),
    GoRoute(
      path: "/ad-rewarded",
      builder: (context, state) => const AdsRewardedScreen(),
    ),
    GoRoute(
      path: "/ad-fullscreen",
      builder: (context, state) => const AdsScreen(),
    ),
    GoRoute(
      path: "/db-pokemons",
      builder: (context, state) => const DbPokemonsScreen(),
    ),
  ],
);
