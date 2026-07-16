import 'package:flutter_test/flutter_test.dart';
import 'package:doctor/main.dart';
import 'package:doctor/services/serverpod_client.dart';

void main() {
  testWidgets('DentalCareApp smoke test', (WidgetTester tester) async {
    initializeServerpod();
    await tester.pumpWidget(const DentalCareApp());
    expect(find.text('Healthy Smile,\nBetter Life'), findsOneWidget);
  });
}
