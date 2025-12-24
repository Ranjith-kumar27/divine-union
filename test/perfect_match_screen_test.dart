import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:divineunion_matrimony/features/registration/ui/perfect_match_screen.dart';

void main() {
  testWidgets('PerfectMatchScreen builds correctly', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: PerfectMatchScreen()));

    // Verify that the title is present.
    expect(find.text('Find Your Perfect Match'), findsOneWidget);

    // Verify that the buttons are present.
    expect(find.text('Get Started'), findsOneWidget);
    expect(find.text('Log in'), findsOneWidget);
  });
}
