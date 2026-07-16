import 'package:dental_client/dental_client.dart' as dc;
import 'package:serverpod_flutter/serverpod_flutter.dart';

late dc.Client client;

Future<void> initializeServerpod() async {
  client = dc.Client('http://localhost:8080/')
    ..connectivityMonitor = FlutterConnectivityMonitor();
}
