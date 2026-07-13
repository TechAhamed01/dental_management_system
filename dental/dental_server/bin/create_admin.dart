import 'dart:io';

import 'package:serverpod/serverpod.dart';
import 'package:dental_server/src/generated/protocol.dart';
import 'package:dental_server/src/generated/endpoints.dart';
import 'package:dental_server/src/utils/password_utils.dart';

void main(List<String> args) async {
  // Use maintenance role to avoid starting the web and API servers
  final pod = Serverpod(
    ['--role', 'maintenance', ...args],
    Protocol(),
    Endpoints(),
    configOverride: (config) {
      if (config.redis != null) {
        final newRedis = RedisConfig(
          enabled: config.redis!.enabled,
          host: config.redis!.host,
          port: config.redis!.port,
          user: config.redis!.user,
          password: null, // Override to null to bypass AUTH
          requireSsl: config.redis!.requireSsl,
        );
        return config.copyWith(redis: newRedis);
      }
      return config;
    },
  );

  await pod.start();

  final session = await pod.createSession(enableLogging: false);

  try {
    var existingAdmin = await Admin.db.findFirstRow(
      session,
      where: (a) => a.email.equals('admin@gmail.com'),
    );

    if (existingAdmin != null) {
      stdout.writeln('Admin already exists');
    } else {
      var passwordHash = PasswordUtils.hashPassword('Admin@123');
      var admin = Admin(
        email: 'admin@gmail.com',
        passwordHash: passwordHash,
      );
      await Admin.db.insertRow(session, admin);
      stdout.writeln('Default admin created successfully.');
    }
  } catch (e) {
    stderr.writeln('Failed to create admin: $e');
  } finally {
    await session.close();
    exit(0);
  }
}
