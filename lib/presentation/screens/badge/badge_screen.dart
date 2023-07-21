import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miselaneos_app/config/plugins/app_badge_plugin.dart';
import 'package:miselaneos_app/presentation/providers/badge/badge_counter_provider.dart';

class BadgeScreen extends ConsumerWidget {
  const BadgeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final badgeCounter = ref.watch(badgeCounterProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(badgeCounterProvider.notifier).update((state) => state + 1);
          AppBadgePlugin.updateBatchCount(badgeCounter + 1);
        },
        child: const Icon(Icons.plus_one),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Badge(
              label: Text("$badgeCounter"),
            ),
            Text(
              "$badgeCounter",
              style: const TextStyle(
                fontSize: 150,
              ),
            ),
            FilledButton.tonal(
              onPressed: () {
                ref.invalidate(badgeCounterProvider);
                AppBadgePlugin.removeBadge();
              },
              child: const Text("Borrar badge"),
            ),
          ],
        ),
      ),
    );
  }
}
