import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sensors_plus/sensors_plus.dart';

class GyroscopeXYZ {
  final double y;
  final double x;
  final double z;

  GyroscopeXYZ(this.y, this.x, this.z);
  @override
  String toString() {
    return """
    x:$x,
    y: $y,
    z: $z
    """;
  }
}

final gyroScopeProvider = StreamProvider.autoDispose((ref) async* {
  await for (final event in gyroscopeEvents) {
    final x = double.parse(event.x.toStringAsFixed(2));
    final z = double.parse(event.z.toStringAsFixed(2));
    final y = double.parse(event.y.toStringAsFixed(2));

    yield GyroscopeEvent(x, y, z);
  }
});
