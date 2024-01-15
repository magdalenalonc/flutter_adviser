import 'package:flutter_adviser/2_application/pages/advice/bloc/adviser_bloc.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('AdviserBloc', () {
    group('should emits', () {
      blocTest<AdviserBloc, AdviserState>(
        'nothing when no event is added',
        build: () => AdviserBloc(),
        expect: () => const <AdviserState>[],
      );

      blocTest(
        '[AdviserStateLoading, AdviserStateError] when AdviceRequestedEvent is added',
        build: () => AdviserBloc(),
        act: (bloc) => bloc.add(AdviceRequestedEvent()),
        wait: const Duration(seconds: 3),
        expect: () => <AdviserState>[
          AdviserStateLoading(),
          AdviserStateError(message: 'error message')
        ],
      );
    });
  });
}
