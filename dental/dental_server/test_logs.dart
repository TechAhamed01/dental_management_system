import 'package:postgres/postgres.dart';
import 'dart:io';

void main() async {
  final connection = await Connection.open(
    Endpoint(
      host: 'localhost',
      database: 'dental',
      username: 'dental',
      password: 'asdf@123',
    ),
    settings: ConnectionSettings(sslMode: SslMode.disable),
  );
  
  final result = await connection.execute('SELECT * FROM serverpod_log ORDER BY id DESC LIMIT 10');
  for (final row in result) {
    print(row);
  }
  await connection.close();
}
