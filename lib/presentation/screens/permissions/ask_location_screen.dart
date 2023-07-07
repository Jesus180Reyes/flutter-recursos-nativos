import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miselaneos_app/presentation/providers/permissions/permissions_provider.dart';

class AskPermissionView extends ConsumerWidget {
  const AskPermissionView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Permiso Requerido"),
      ),
      body: Center(
        child: FilledButton(
          onPressed: () {
            ref.read(permissionProvider.notifier).requestLocationAccess();
          },
          child: const Text("Localization necesaria"),
        ),
      ),
    );
  }
}
