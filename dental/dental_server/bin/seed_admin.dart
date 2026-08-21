import 'dart:io';
import 'package:serverpod/serverpod.dart';
import 'package:dental_server/src/generated/protocol.dart';
import 'package:dental_server/src/generated/endpoints.dart';
import 'package:dental_server/src/utils/password_utils.dart';

void main(List<String> args) async {
  final pod = Serverpod(
    args,
    Protocol(),
    Endpoints(),
    configOverride: (config) {
      if (config.redis != null) {
        final newRedis = RedisConfig(
          enabled: config.redis!.enabled,
          host: config.redis!.host,
          port: config.redis!.port,
          user: config.redis!.user,
          password: null,
          requireSsl: config.redis!.requireSsl,
        );
        return config.copyWith(redis: newRedis);
      }
      return config;
    },
  );
  await pod.start();

  final session = await pod.createSession();
  try {
    final existing = await Admin.db.findFirstRow(session, where: (t) => t.email.equals('admin@dental.ai'));
    if (existing == null) {
      final admin = Admin(
        email: 'admin@dental.ai',
        passwordHash: PasswordUtils.hashPassword('Admin@123'),
      );
      await Admin.db.insertRow(session, admin);
      print('Admin seeded successfully.');
    } else {
      print('Admin already exists.');
    }
  } catch (e) {
    print('Error seeding admin: $e');
  } finally {
    await session.close();
    exit(0);
  }
}
