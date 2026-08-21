import 'package:dental_client/dental_client.dart';
import 'package:serverpod_client/serverpod_client.dart';

void main() async {
  final client = Client('http://localhost:8080/');
  try {
    await client.auth.getPendingDentists();
  } catch (e) {
    print('EXCEPTION WAS: ' + e.toString());
  }
}
