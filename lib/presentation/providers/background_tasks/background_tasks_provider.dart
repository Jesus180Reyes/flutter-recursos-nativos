import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miselaneos_app/config/workmanager/callback_dispatcher.dart';
import 'package:workmanager/workmanager.dart';

class BackgroundFetchNotifier extends StateNotifier<bool?> {
  final String processKeyName;
  BackgroundFetchNotifier({required this.processKeyName}) : super(false) {
    checkCurrentStatus();
  }
  checkCurrentStatus() async {}
  toggleProcess() {}

  activateTask() async {
    await Workmanager().registerPeriodicTask(
      processKeyName,
      processKeyName,
      frequency: const Duration(seconds: 10),
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
      tag: processKeyName,
    );
  }
}

final backgroundPokemonFetchProvider =
    StateNotifierProvider<BackgroundFetchNotifier, bool?>(
  (ref) {
    return BackgroundFetchNotifier(
      processKeyName: fetchPeriodicBackgroundTaskKey,
    );
  },
);
