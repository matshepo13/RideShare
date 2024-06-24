import 'package:firebase_auth/firebase_auth.dart';
import 'package:lifts_app/services/auth_service.dart';

class CreateAccountViewModel {
  final AuthService _authService = AuthService();

  Future<User?> signUp(String email, String password) async {
    try {
      User? user = await _authService.signUpWithEmailAndPassword(email, password);
      return user;
    } catch (e) {
      throw e;
    }
  }
}