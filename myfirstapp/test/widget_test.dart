// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:myfirstapp/main.dart';

void main() {
  testWidgets('navigates and disables Change Text after tapping', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Go to Interactive Screen'));
    await tester.pumpAndSettle();

    expect(find.text('Press the button below'), findsOneWidget);
    final changeTextButton = find.widgetWithText(
      ElevatedButton,
      'Change Text',
    );
    expect(changeTextButton, findsOneWidget);

    await tester.tap(changeTextButton);
    await tester.pumpAndSettle();

    expect(find.text('Hello! The text has changed.'), findsOneWidget);
    expect(find.text('Text Changed'), findsOneWidget);
    expect(
      tester.widget<ElevatedButton>(find.widgetWithText(
        ElevatedButton,
        'Text Changed',
      )).onPressed,
      isNull,
    );
  });
}
