import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miselaneos_app/presentation/providers/sensors/compass/compaa_provider.dart';
import '../../providers/permissions/permissions_provider.dart';
import '../permissions/ask_location_screen.dart';

class CompassScreen extends ConsumerWidget {
  const CompassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final locationGranted = ref.watch(permissionProvider).locationGranted;
    if (!locationGranted) {
      return const AskPermissionView();
    }
    final compassHeading = ref.watch(compassProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: const Text(
          "Brujula",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: compassHeading.when(
          data: (heading) => Compass(heading: heading ?? 0),
          error: (error, stroke) => Text(
            "$error",
            style: const TextStyle(color: Colors.white),
          ),
          loading: () => const CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }
}

class Compass extends StatefulWidget {
  final double heading;
  const Compass({super.key, required this.heading});

  @override
  State<Compass> createState() => _CompassState();
}

class _CompassState extends State<Compass> {
  double prevValue = 0.0;
  double turns = 0;

  double getTurns() {
    double? direction = widget.heading;
    direction = (direction < 0) ? (360 + direction) : direction;

    double diff = direction - prevValue;
    if (diff.abs() > 180) {
      if (prevValue > direction) {
        diff = 360 - (direction - prevValue).abs();
      } else {
        diff = 360 - (prevValue - direction).abs();
        diff = diff * -1;
      }
    }

    turns += (diff / 360);
    prevValue = direction;

    return turns * -1;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "${widget.heading.ceil()}",
          style: const TextStyle(color: Colors.white, fontSize: 30),
        ),
        const SizedBox(height: 20),
        Stack(
          alignment: Alignment.center,
          children: [
            // Image.asset("assets/images/quadrant-1.png"),
            // Transform.rotate(
            //   angle: heading + (pi / 100) * -1,
            //   child:
            // ),
            AnimatedRotation(
              curve: Curves.easeOut,
              turns: getTurns(),
              duration: const Duration(seconds: 1),
              child: Image.asset("assets/images/quadrant-1.png"),
            ),
            Image.asset("assets/images/needle-1.png"),
          ],
        )
      ],
    );
  }
}
