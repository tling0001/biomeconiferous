// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:biomeconiferous/main.dart';

void main() {
  testWidgets('Biome app loads title page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const BiomeConiferousApp());

    expect(find.text('Coniferous Forest Biome'), findsOneWidget);
    final hasBottomBar = find.byType(NavigationBar).evaluate().isNotEmpty;
    final hasSideRail = find.byType(NavigationRail).evaluate().isNotEmpty;
    expect(hasBottomBar || hasSideRail, isTrue);
  });
}
