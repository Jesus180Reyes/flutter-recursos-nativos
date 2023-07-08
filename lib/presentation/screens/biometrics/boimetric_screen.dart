import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miselaneos_app/presentation/providers/local_auth/local_auth_providers.dart';

class BiometricScreen extends ConsumerWidget {
  const BiometricScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final canCheckBiometrics = ref.watch(canCheckBiometricsProvider);
    final localAuthState = ref.watch(localAuthNotifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Biometric"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton.tonal(
              onPressed: () {
                ref.read(localAuthNotifier.notifier).authenticatingUser();
              },
              child: const Text("Autenticar"),
            ),
            canCheckBiometrics.when(
              data: (canCheck) => Text("Puede revisar biometricos $canCheck"),
              error: (e, _) => Text("Error: $e"),
              loading: () => const CircularProgressIndicator.adaptive(),
            ),
            const SizedBox(height: 20),
            const Text(
              "Estado del biometrico",
              style: TextStyle(fontSize: 30),
            ),
            Text(
              "Estado: $localAuthState ",
              style: const TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }
}
