import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miselaneos_app/presentation/providers/sensors/accelerometer_provider.dart';

class AcelerometerScreen extends ConsumerWidget {
  const AcelerometerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final accelerometerScope$ = ref.watch(accelerometerUserProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Acelerometer"),
      ),
      body: Center(
        child: accelerometerScope$.when(
          data: (data) => Text('$data'),
          error: (error, strack) => Text('$error'),
          loading: () => const CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }
}
