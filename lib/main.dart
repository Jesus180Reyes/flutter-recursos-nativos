import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miselaneos_app/config/config.dart';
import 'package:miselaneos_app/config/plugins/quick_action_plugin.dart';
import 'package:miselaneos_app/presentation/providers/providers.dart';
import 'package:workmanager/workmanager.dart';

import 'config/workmanager/callback_dispatcher.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode:
          true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
      );
  Workmanager().registerOneOffTask(
    "com.jesusreyes.miselaneos.simpleTask",
    "com.jesusreyes.miselaneos.simpleTask",
    inputData: {"hola": "hola"},
    constraints: Constraints(
      networkType: NetworkType.connected,
      // requiresBatteryNotLow: true,
      // requiresCharging: true,
      // requiresDeviceIdle: true,
      // requiresStorageNotLow: true,
    ),
  );
  QuickActionPlugin.registerActions();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  MainAppState createState() => MainAppState();
}

class MainAppState extends ConsumerState<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    ref.read(permissionProvider.notifier).checkPermissions();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    ref.read(appStateProvider.notifier).state = state;
    if (state == AppLifecycleState.resumed) {
      ref.read(permissionProvider.notifier).checkPermissions();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      title: 'Miselaneos App',
    );
  }
}
