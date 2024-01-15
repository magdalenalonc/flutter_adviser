import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adviser/2_application/pages/advice/widgets/error_message.dart';

void main() {
  Widget widgetUnderTest({required String message}) {
    return MaterialApp(
      home: ErrorMessage(message: message),
    );
  }

  group('ErrorMessage', () {
    group('should be displayed correctly', () {
      testWidgets(
        'when a short text is given',
        (widgetTester) async {
          const message = 'a';

          await widgetTester.pumpWidget(widgetUnderTest(message: message));
          await widgetTester.pumpAndSettle();

          final errorMessageFinder = find.byType(ErrorMessage);

          expect(errorMessageFinder, findsOneWidget);
        },
      );

      testWidgets(
        'when a long text is given',
        (widgetTester) async {
          const message =
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';

          await widgetTester.pumpWidget(widgetUnderTest(message: message));
          await widgetTester.pumpAndSettle();

          final errorMessageFinder = find.byType(ErrorMessage);

          expect(errorMessageFinder, findsOneWidget);
        },
      );
    });
  });
}
