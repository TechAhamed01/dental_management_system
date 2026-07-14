import 'package:dental_client/dental_client.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

late Client client;

Future<void> initializeServerpod() async {
  client = Client('http://localhost:8080/');
}
