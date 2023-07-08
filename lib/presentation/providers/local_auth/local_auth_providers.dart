// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:miselaneos_app/config/plugins/local_auth_plugin.dart';

final canCheckBiometricsProvider = FutureProvider<bool>((ref) async {
  return await LocalAuthPlugin.canCheckBiometrics();
});

enum LocalAuthStatus { authenticated, notAuthenticated, authenticating }

class LocalAuthState {
  final bool didAuthenticated;
  final LocalAuthStatus status;
  final String message;

  LocalAuthState({
    this.didAuthenticated = false,
    this.status = LocalAuthStatus.notAuthenticated,
    this.message = '',
  });

  LocalAuthState copyWith({
    bool? didAuthenticated,
    LocalAuthStatus? status,
    String? message,
  }) {
    return LocalAuthState(
      didAuthenticated: didAuthenticated ?? this.didAuthenticated,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  String toString() {
    return '''
    "didAuthenticated": $didAuthenticated
    "status": $status
    "message": $message
''';
  }
}

class LocalAuthNotifier extends StateNotifier<LocalAuthState> {
  LocalAuthNotifier() : super(LocalAuthState());

  Future<(bool, String)> authenticatingUser() async {
    final (didAuth, message) = await LocalAuthPlugin.authenticate();
    state = state.copyWith(
      didAuthenticated: didAuth,
      message: message,
      status: didAuth
          ? LocalAuthStatus.authenticated
          : LocalAuthStatus.notAuthenticated,
    );
    return (didAuth, message);
  }
}

final localAuthNotifier =
    StateNotifierProvider<LocalAuthNotifier, LocalAuthState>((ref) {
  return LocalAuthNotifier();
});
