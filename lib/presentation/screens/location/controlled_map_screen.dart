import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:miselaneos_app/presentation/providers/location/map_controller_provider.dart';
import 'package:miselaneos_app/presentation/providers/location/use_location_provider.dart';

class ControlledMapScreen extends ConsumerWidget {
  const ControlledMapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    // final watchLocation = ref.watch(watchLocationProvider);
    final useInitialLocation = ref.watch(userLocationProvider);
    return Scaffold(
      body: useInitialLocation.when(
        data: (data) => MapAndControls(latitude: data.$1, longitude: data.$2),
        error: (error, stackTrace) => Text(e.toString()),
        loading: () => const CircularProgressIndicator.adaptive(),
      ),
    );
  }
}

class MapAndControls extends ConsumerWidget {
  final double latitude;
  final double longitude;
  const MapAndControls(
      {super.key, required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context, ref) {
    final mapControllerState = ref.watch(mapControllerProvider);
    return Stack(
      children: [
        _MapView(initialLatitude: latitude, initialLongitude: longitude),
        Positioned(
          top: 40,
          left: 20,
          child: IconButton.filledTonal(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        Positioned(
          bottom: 40,
          left: 20,
          child: IconButton.filledTonal(
            onPressed: () {
              ref.read(mapControllerProvider.notifier).findUser();
            },
            icon: const Icon(Icons.location_searching),
          ),
        ),
        Positioned(
          bottom: 90,
          left: 20,
          child: IconButton.filledTonal(
            onPressed: () {
              ref.read(mapControllerProvider.notifier).toggleFollowUser();
            },
            icon: Icon(mapControllerState.followUser
                ? Icons.directions_run
                : Icons.accessibility_new),
          ),
        ),
        Positioned(
          bottom: 140,
          left: 20,
          child: IconButton.filledTonal(
            onPressed: () {
              ref
                  .read(mapControllerProvider.notifier)
                  .addMarkerCurrentPosition();
            },
            icon: const Icon(Icons.pin_drop),
          ),
        ),
      ],
    );
  }
}

class _MapView extends ConsumerWidget {
  final double initialLatitude;
  final double initialLongitude;
  const _MapView({
    required this.initialLatitude,
    required this.initialLongitude,
  });

  @override
  Widget build(BuildContext context, ref) {
    final mapController = ref.watch(mapControllerProvider);
    return GoogleMap(
      onLongPress: (argument) {
        ref
            .read(mapControllerProvider.notifier)
            .addMarker(argument.longitude, argument.latitude, "Nuevo marker");
      },
      markers: mapController.setMarkers,
      mapType: MapType.normal,
      myLocationButtonEnabled: false,
      myLocationEnabled: true,
      initialCameraPosition: CameraPosition(
        zoom: 15,
        target: LatLng(
          initialLatitude,
          initialLongitude,
        ),
      ),
      onMapCreated: (GoogleMapController controller) {
        ref.read(mapControllerProvider.notifier).setMapController(controller);
        // _controller.complete(controller);
      },
    );
  }
}
