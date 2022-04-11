import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserAuthService {
  final Supabase _client = Supabase.instance;

  signUp(email, password) async {
    try {

      final response = await _client.client.auth.signUp(email, password);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  login(email, password) async {
    try {
      final response = await _client.client.auth.signIn(
        email: email,
        password: password,
      );
      return response;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  logout() async {
    try {
      final response = await _client.client.auth.signOut();
      return response;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  checkLogin() {
    final User? response = _client.client.auth.currentSession?.user;
    return response;
  }
}
