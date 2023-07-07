import 'package:flutter/material.dart';

class BiometricScreen extends StatelessWidget {
  const BiometricScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Biometric"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton.tonal(
              onPressed: () {},
              child: const Text("Autenticar"),
            ),
            const SizedBox(height: 20),
            const Text(
              "Estado del biometrico",
              style: TextStyle(fontSize: 30),
            ),
            const Text(
              "Estado: ",
              style: TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }
}
