// ignore_for_file: depend_on_referenced_packages
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

class LocalAuthPlugin {
  static final LocalAuthentication auth = LocalAuthentication();
  static availableBiometrics() async {
    final List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();

    if (availableBiometrics.isNotEmpty) {
      // Some biometrics are enrolled.
    }

    if (availableBiometrics.contains(BiometricType.strong) ||
        availableBiometrics.contains(BiometricType.face)) {
      // Specific types of biometrics are available.
      // Use checks like this with caution!
    }
  }

  static Future<bool> canCheckBiometrics() async {
    return await auth.canCheckBiometrics;
  }

  static Future<(bool, String)> authenticate() async {
    try {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Porfavor autenticate para continuar',
        authMessages: const [
          AndroidAuthMessages(
            signInTitle: "Se necesita Autenticacion para continuar",
            biometricHint: "Ingresa tu huella",
            cancelButton: "No Gracias",
          ),
          IOSAuthMessages(
            cancelButton: "No gracias",
          ),
        ],
        options: const AuthenticationOptions(biometricOnly: true),
        // biometricOnly: true
      );

      return (
        didAuthenticate,
        didAuthenticate ? "Hecho" : "Cancelado por usuario"
      );
    } on PlatformException catch (e) {
      if (e.code == auth_error.notEnrolled) {
        return (false, "No hay biometricos enrolados");
      }
      if (e.code == auth_error.lockedOut) {
        return (false, "Muchos intentos fallidos");
      }
      if (e.code == auth_error.notAvailable) {
        return (false, " No hay biometricos disponibles");
      }
      if (e.code == auth_error.passcodeNotSet) {
        return (false, " No hay un PIN configurado");
      }
      if (e.code == auth_error.permanentlyLockedOut) {
        return (false, " Se requiere desbloquear el telefono ");
      }
      return (false, e.toString());
    }
  }
}
