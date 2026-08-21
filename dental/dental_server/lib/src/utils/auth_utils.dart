import 'package:serverpod/serverpod.dart';
import 'jwt_utils.dart';

class AuthenticatedUser {
  final int userId;
  final String role;
  final int? hospitalId;

  AuthenticatedUser({
    required this.userId,
    required this.role,
    this.hospitalId,
  });
}

class AuthUtils {
  static AuthenticatedUser? getAuthenticatedUser(Session session) {
    var token = session.authenticationKey;
    if (token == null) {
      return null;
    }

    if (token.startsWith('Bearer ')) {
      token = token.substring(7);
    }

    final jwt = JwtUtils.verifyAccessToken(token);
    if (jwt == null) {
      return null;
    }

    return AuthenticatedUser(
      userId: jwt.payload['userId'] as int,
      role: jwt.payload['role'] as String,
      hospitalId: jwt.payload['hospitalId'] as int?,
    );
  }

  static AuthenticatedUser requireRole(Session session, List<String> allowedRoles) {
    final user = getAuthenticatedUser(session);
    
    if (user == null) {
      throw Exception('Unauthorized. Missing or invalid token.');
    }
    
    if (!allowedRoles.contains(user.role)) {
      throw Exception('Forbidden. Insufficient permissions for role: ${user.role}.');
    }
    
    return user;
  }
}
