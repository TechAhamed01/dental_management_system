import 'package:flutter/foundation.dart';
import 'package:dental_client/dental_client.dart' as dc;
import '../services/serverpod_client.dart';

class AuthRepository {
  Future<dc.AuthResponse> login(String email, String password) async {
    debugPrint("[AuthRepository] API request started: client.auth.dentistLogin($email)");
    final response = await client.auth.dentistLogin(email, password);
    debugPrint("[AuthRepository] API response received: $response");
    return response;
  }
}
