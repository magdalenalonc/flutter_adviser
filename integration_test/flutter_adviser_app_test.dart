import 'package:flutter_adviser/2_application/pages/advice/widgets/advice_field.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_adviser/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets(
      'tap on CustomButton, verify advice will be load',
      (widgetTester) async {
        app.main();
        await widgetTester.pumpAndSettle();

        // verify that no advice has been loaded
        expect(find.text('Your advice is waiting for you!'), findsOneWidget);

        // find CustomButton
        final customButtonFinder = find.text('Get Advice');

        // emulate a tap on the CustomButton
        await widgetTester.tap(customButtonFinder);

        // trigger a frame and wait until its settled
        await widgetTester.pumpAndSettle();

        // verify that an advice was loaded
        expect(find.byType(AdviceField), findsOneWidget);
        expect(find.textContaining('" '), findsOneWidget);
        expect(find.textContaining(' "'), findsOneWidget);
      },
    );
  });
}
