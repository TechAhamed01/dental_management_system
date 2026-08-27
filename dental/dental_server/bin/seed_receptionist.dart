import 'dart:io';
import 'package:serverpod/serverpod.dart';
import 'package:dental_server/src/generated/protocol.dart';
import 'package:dental_server/src/generated/endpoints.dart';
import 'package:dental_server/src/utils/password_utils.dart';

void main(List<String> args) async {
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
          password: null,
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
    // 1. Create or Find the Hospital
    final hospitalName = 'Phase 2 Test Hospital';
    var hospital = await Hospital.db.findFirstRow(
      session,
      where: (t) => t.name.equals(hospitalName),
    );

    if (hospital == null) {
      hospital = Hospital(
        name: hospitalName,
        address: 'Chennai',
        phone: '9000000000',
        email: 'phase2@test.com',
        isActive: true,
        createdAt: DateTime.now(),
      );
      hospital = await Hospital.db.insertRow(session, hospital);
      print('Hospital created successfully with ID: ${hospital.id}');
    } else {
      print('Hospital already exists with ID: ${hospital.id}');
    }

    // 2. Create the Receptionist
    final email = 'receptionist@test.com';
    final password = 'Test@12345';
    final existing = await Receptionist.db.findFirstRow(session, where: (t) => t.email.equals(email));
    
    if (existing == null) {
      final receptionist = Receptionist(
        hospitalId: hospital.id!,
        fullName: 'Test Receptionist',
        email: email,
        phone: '9111111111',
        passwordHash: PasswordUtils.hashPassword(password),
        isActive: true,
        createdAt: DateTime.now(),
      );
      await Receptionist.db.insertRow(session, receptionist);
      print('Receptionist seeded successfully. You can now log in with:');
      print('Email: $email');
      print('Password: $password');
    } else {
      print('Receptionist already exists.');
    }
  } catch (e) {
    print('Error seeding receptionist: $e');
  } finally {
    await session.close();
    exit(0);
  }
}
