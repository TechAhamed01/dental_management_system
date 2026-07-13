import 'package:test/test.dart';
import 'package:dental_server/src/utils/password_utils.dart';
import 'package:dental_server/src/utils/jwt_utils.dart';

void main() {
  group('Auth Unit Tests', () {
    test('Password hashing creates distinct hash from password', () {
      final pass = 'securePassword123';
      final hash = PasswordUtils.hashPassword(pass);
      expect(hash, isNot(equals(pass)));
      expect(PasswordUtils.verifyPassword(pass, hash), isTrue);
      expect(PasswordUtils.verifyPassword('wrong', hash), isFalse);
    });

    test('JWT generation and verification works', () {
      final token = JwtUtils.generateAccessToken(1, 'patient');
      final jwt = JwtUtils.verifyAccessToken(token);
      expect(jwt, isNotNull);
      expect(jwt!.payload['userId'], equals(1));
      expect(jwt.payload['role'], equals('patient'));
    });
  });
}
