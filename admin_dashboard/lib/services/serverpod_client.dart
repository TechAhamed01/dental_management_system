import 'package:dental_client/dental_client.dart';

late Client client;

Future<void> initializeServerpod() async {
  client = Client('http://localhost:8080/');
}
