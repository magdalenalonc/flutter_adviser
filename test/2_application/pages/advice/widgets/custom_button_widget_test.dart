import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_adviser/2_application/pages/advice/widgets/custom_button.dart';

abstract class OnCustomButtonTap {
  void call();
}

class MockOnCustomButtonTap extends Mock implements OnCustomButtonTap {}

void main() {
  Widget widgetUnderTest({Function()? callback}) {
    return MaterialApp(
      home: Scaffold(
        body: CustomButton(
          onTap: callback,
        ),
      ),
    );
  }

  group('CustomButton', () {
    group('is button rendered correctly', () {
      testWidgets(
        'and has all parts that it needs',
        (widgetTester) async {
          await widgetTester.pumpWidget(widgetUnderTest());

          final buttonLabelFinder = find.text('Get Advice');

          expect(buttonLabelFinder, findsOneWidget);
        },
      );
    });

    group('should handle onTap', () {
      testWidgets(
        'when someone has pressed the button',
        (widgetTester) async {
          final mockOnCustomButtonTap = MockOnCustomButtonTap();

          await widgetTester.pumpWidget(
              widgetUnderTest(callback: mockOnCustomButtonTap.call));

          final customButtonFinder = find.byType(CustomButton);

          await widgetTester.tap(customButtonFinder);

          verify(mockOnCustomButtonTap()).called(1);
        },
      );
    });
  });
}
