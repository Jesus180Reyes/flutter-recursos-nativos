import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miselaneos_app/presentation/providers/location/use_location_provider.dart';
import 'package:miselaneos_app/presentation/providers/location/watch_location_provider.dart';
import 'package:miselaneos_app/presentation/providers/permissions/permissions_provider.dart';

class LocationScreen extends ConsumerWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final userLocationAsync = ref.watch(userLocationProvider);
    final watchLocationAsync = ref.watch(watchLocationProvider);
    final permission = ref.watch(permissionProvider);
    if (!permission.locationGranted) {
      return Scaffold(
        body: Center(
          child: FilledButton.tonal(
            onPressed: () {
              ref.read(permissionProvider.notifier).requestLocationAccess();
            },
            child: const Text("Activar location"),
          ),
        ),
      );
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Ubicacion actual"),
            userLocationAsync.when(
              data: (data) => Text("$data"),
              error: (error, stackTrace) => Text('$error'),
              loading: () => const CircularProgressIndicator.adaptive(),
            ),
            const SizedBox(height: 30),
            const Text("5eguimiento de ubicacion"),
            watchLocationAsync.when(
              data: (data) => Text("$data"),
              error: (error, stackTrace) => Text('$error'),
              loading: () => const CircularProgressIndicator.adaptive(),
            ),
          ],
        ),
      ),
    );
  }
}
