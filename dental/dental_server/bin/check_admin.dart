import 'package:serverpod/serverpod.dart';
import 'package:dental_server/src/generated/protocol.dart';
import 'package:dental_server/src/generated/endpoints.dart';
import 'package:dental_server/src/utils/password_utils.dart';
import 'dart:io';

void main(List<String> args) async {
  final pod = Serverpod(
    args,
    Protocol(),
    Endpoints(),
  );
  await pod.start();
  final session = await pod.createSession();
  
  final admin = await Admin.db.findFirstRow(session, where: (t) => t.email.equals('admin@dental.ai'));
  if (admin == null) {
    print('Admin not found!');
  } else {
    print('Found admin! Hash: ' + admin.passwordHash);
    final match = PasswordUtils.verifyPassword('Admin@123', admin.passwordHash);
    print('Password match? ' + match.toString());
  }
  await session.close();
  exit(0);
}
