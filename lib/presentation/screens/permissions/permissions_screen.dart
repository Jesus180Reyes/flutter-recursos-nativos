import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miselaneos_app/presentation/providers/permissions/permissions_provider.dart';

class PermissionsScreen extends StatelessWidget {
  const PermissionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Permissions"),
      ),
      body: const _PermissionView(),
    );
  }
}

class _PermissionView extends ConsumerWidget {
  const _PermissionView();

  @override
  Widget build(BuildContext context, ref) {
    final permissions = ref.watch(permissionProvider);

    return ListView(
      children: [
        CheckboxListTile(
          value: permissions.cameraGranted,
          title: const Text("Camara"),
          subtitle: Text("${permissions.camera}"),
          onChanged: (_) async {
            await ref.read(permissionProvider.notifier).requstCameraAccess();
          },
        ),
        CheckboxListTile(
          value: permissions.photoLibraryGranted,
          title: const Text("Galeria de Fotos"),
          subtitle: Text("${permissions.photoLibrary}"),
          onChanged: (_) async {
            await ref.read(permissionProvider.notifier).requestGalleryAccess();
          },
        ),
        CheckboxListTile(
          value: permissions.sensorsGranted,
          title: const Text("Sensors"),
          subtitle: Text("${permissions.camera}"),
          onChanged: (_) async {
            await ref.read(permissionProvider.notifier).requestSensorsAccess();
          },
        ),
        CheckboxListTile(
          value: permissions.locationGranted,
          title: const Text("Location"),
          subtitle: Text("${permissions.camera}"),
          onChanged: (_) async {
            await ref.read(permissionProvider.notifier).requestLocationAccess();
          },
        ),
      ],
    );
  }
}
