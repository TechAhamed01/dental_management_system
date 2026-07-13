import 'package:bcrypt/bcrypt.dart';

class PasswordUtils {
  static String hashPassword(String password) {
    return BCrypt.hashpw(password, BCrypt.gensalt());
  }

  static bool verifyPassword(String password, String hashed) {
    try {
      return BCrypt.checkpw(password, hashed);
    } catch (_) {
      return false;
    }
  }
}
