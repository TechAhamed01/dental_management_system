import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class JwtUtils {
  static const String _secretKey = 'super_secret_jwt_key_should_be_in_env_in_production';
  static const String _refreshSecretKey = 'super_secret_refresh_key_in_production';

  static String generateAccessToken(int userId, String role, {int? hospitalId}) {
    final payload = <String, dynamic>{
      'userId': userId,
      'role': role,
    };
    if (hospitalId != null) {
      payload['hospitalId'] = hospitalId;
    }
    final jwt = JWT(payload);
    return jwt.sign(SecretKey(_secretKey), expiresIn: const Duration(hours: 1));
  }

  static String generateRefreshToken(int userId, String role, {int? hospitalId}) {
    final payload = <String, dynamic>{
      'userId': userId,
      'role': role,
    };
    if (hospitalId != null) {
      payload['hospitalId'] = hospitalId;
    }
    final jwt = JWT(payload);
    return jwt.sign(SecretKey(_refreshSecretKey), expiresIn: const Duration(days: 7));
  }

  static JWT? verifyAccessToken(String token) {
    try {
      return JWT.verify(token, SecretKey(_secretKey));
    } catch (_) {
      return null;
    }
  }

  static JWT? verifyRefreshToken(String token) {
    try {
      return JWT.verify(token, SecretKey(_refreshSecretKey));
    } catch (_) {
      return null;
    }
  }
}
