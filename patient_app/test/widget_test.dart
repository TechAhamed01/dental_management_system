// This is a basic Flutter widget test.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patient_app/main.dart';

void main() {
  testWidgets('PatientApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const PatientApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
