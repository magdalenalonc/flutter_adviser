import 'package:flutter/material.dart';
import 'package:flutter_adviser/2_application/pages/advice/widgets/advice_field.dart';
import 'package:flutter_adviser/2_application/pages/advice/widgets/error_message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:provider/provider.dart';
import 'package:flutter_adviser/2_application/pages/advice/advice_page.dart';
import 'package:flutter_adviser/2_application/core/services/theme_service.dart';
import 'package:flutter_adviser/2_application/pages/advice/cubit/adviser_cubit.dart';

class MockAdviserCubit extends MockCubit<AdviserCubitState>
    implements AdviserCubit {}

void main() {
  Widget widgetUnderTest({required AdviserCubit cubit}) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => ThemeService(),
        child: BlocProvider<AdviserCubit>(
          create: (context) => cubit,
          child: const AdvicePage(),
        ),
      ),
    );
  }

  group('AdvicePage', () {
    late AdviserCubit mockAdviserCubit;

    setUp(() => mockAdviserCubit = MockAdviserCubit());

    group('should be displayed in ViewState', () {
      testWidgets(
        'Initial when cubit emits AdviserInitial()',
        (widgetTester) async {
          whenListen(
            mockAdviserCubit,
            Stream.fromIterable(const [AdviserInitial()]),
            initialState: const AdviserInitial(),
          );

          await widgetTester
              .pumpWidget(widgetUnderTest(cubit: mockAdviserCubit));

          final adviserInitialFinder =
              find.text('Your advice is waiting for you!');

          expect(adviserInitialFinder, findsOneWidget);
        },
      );

      testWidgets(
        'Loading when cubit emits AdviserStateLoading()',
        (widgetTester) async {
          whenListen(
            mockAdviserCubit,
            Stream.fromIterable(const [AdviserStateLoading()]),
            initialState: const AdviserInitial(),
          );

          await widgetTester
              .pumpWidget(widgetUnderTest(cubit: mockAdviserCubit));
          await widgetTester.pump();

          final adviserLoadingFinder = find.byType(CircularProgressIndicator);

          expect(adviserLoadingFinder, findsOneWidget);
        },
      );

      testWidgets(
        'advice text when cubit emits AdviserStateLoaded()',
        (widgetTester) async {
          whenListen(
            mockAdviserCubit,
            Stream.fromIterable(const [AdviserStateLoaded(advice: '13')]),
            initialState: const AdviserInitial(),
          );

          await widgetTester
              .pumpWidget(widgetUnderTest(cubit: mockAdviserCubit));
          await widgetTester.pump();

          final adviserLoadedFinder = find.byType(AdviceField);
          final adviceText =
              widgetTester.widget<AdviceField>(adviserLoadedFinder).advice;

          expect(adviserLoadedFinder, findsOneWidget);
          expect(adviceText, '13');
        },
      );

      testWidgets(
        'Error when cubit emits AdviserStateError()',
        (widgetTester) async {
          whenListen(
            mockAdviserCubit,
            Stream.fromIterable(const [AdviserStateError(message: 'error')]),
            initialState: const AdviserInitial(),
          );

          await widgetTester
              .pumpWidget(widgetUnderTest(cubit: mockAdviserCubit));
          await widgetTester.pump();

          final adviserErrorFinder = find.byType(ErrorMessage);

          expect(adviserErrorFinder, findsOneWidget);
        },
      );
    });
  });
}
