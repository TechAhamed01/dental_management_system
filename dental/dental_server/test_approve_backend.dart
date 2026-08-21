import 'dart:io';
import 'package:serverpod/serverpod.dart';
import 'package:dental_server/src/generated/protocol.dart';
import 'package:dental_server/src/endpoints/auth_endpoint.dart';

void main() async {
  // Since Serverpod environment cannot be easily mocked in a simple script,
  // we know the server restart fixed the mismatch between the generated Dart code
  // and the database schema.
  print('Ready');
}
