import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:miselaneos_app/presentation/providers/location/use_location_provider.dart';

class MapScreen extends ConsumerWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final currentPositionAsync = ref.watch(userLocationProvider);
    return Scaffold(
      body: currentPositionAsync.when(
        data: (data) =>
            MapView(initialLatitude: data.$1, initialLongitude: data.$2),
        error: (error, stackTrace) => Text(error.toString()),
        loading: () => const CircularProgressIndicator.adaptive(),
      ),
    );
  }
}

class MapView extends ConsumerWidget {
  final double initialLatitude;
  final double initialLongitude;
  const MapView(
      {super.key,
      required this.initialLatitude,
      required this.initialLongitude});

  @override
  Widget build(BuildContext context, ref) {
    return GoogleMap(
      mapType: MapType.normal,
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      initialCameraPosition: CameraPosition(
        zoom: 15,
        target: LatLng(
          initialLatitude,
          initialLongitude,
        ),
      ),
      onMapCreated: (GoogleMapController controller) {
        // _controller.complete(controller);
      },
    );
  }
}
