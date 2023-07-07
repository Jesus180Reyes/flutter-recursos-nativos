import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miselaneos_app/presentation/providers/providers.dart';

class GyrosScopeScreen extends ConsumerWidget {
  const GyrosScopeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final gyroscopeRef = ref.watch(gyroScopeProvider);
    return Scaffold(
      body: Center(
        child: gyroscopeRef.when(
          data: (data) => Text(
            data.toString(),
            style: const TextStyle(fontSize: 30),
          ),
          error: (error, strackTrace) => Text("$error"),
          loading: () => const CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }
}
