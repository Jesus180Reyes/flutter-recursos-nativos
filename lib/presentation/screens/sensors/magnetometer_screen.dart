import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miselaneos_app/presentation/providers/sensors/magnetometer_provider.dart';

class MagnetometerScreen extends ConsumerWidget {
  const MagnetometerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final magnetometerScope$ = ref.watch(magnetometerProvider);
    return Scaffold(
      body: Center(
        child: magnetometerScope$.when(
          data: (data) => Text("$data"),
          error: (error, strack) => Text(error.toString()),
          loading: () => const CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }
}
