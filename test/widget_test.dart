// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:financial_advisory/main.dart';

void main() {
  testWidgets('Splash Screen Smoke Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that SplashScreen is displayed and shows the app title.
    expect(find.text('Financial Advisory'), findsOneWidget);
    expect(find.text('Your Smart UPI Assistant'), findsOneWidget);

    // Settle the pending delayed timer by pumping 2 seconds of virtual time
    await tester.pump(const Duration(seconds: 2));
  });
}
