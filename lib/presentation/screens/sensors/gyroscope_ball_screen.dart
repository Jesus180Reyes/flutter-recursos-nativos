import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miselaneos_app/presentation/providers/providers.dart';

class GyroScopeBallScreen extends ConsumerWidget {
  const GyroScopeBallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final gyrosScope$ = ref.watch(gyroScopeProvider);

    return Scaffold(
      body: SizedBox.expand(
        child: gyrosScope$.when(
          data: (value) => MovingBall(x: value.x, y: value.y),
          error: (error, stackTrace) => Text("$error"),
          loading: () => const Scaffold(
            body: Center(child: CircularProgressIndicator.adaptive()),
          ),
        ),
      ),
    );
  }
}

class MovingBall extends StatelessWidget {
  final double x;
  final double y;
  const MovingBall({super.key, required this.x, required this.y});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double screenWidth = size.width;
    double screenHeight = size.height;

    double currentYPos = (y * 150);
    double currentXPos = (x * 150);

    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedPositioned(
          left: (currentYPos - 25) + (screenWidth / 2),
          top: (currentXPos - 25) + (screenHeight / 2),
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 1000),
          child: const Ball(),
        ),
        Text(
          """
          x:$x,
          y:$y
        """,
          style: const TextStyle(fontSize: 40),
        ),
      ],
    );
  }
}

class Ball extends StatelessWidget {
  const Ball({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: const BoxDecoration(
        color: Colors.indigo,
        shape: BoxShape.circle,
      ),
    );
  }
}
