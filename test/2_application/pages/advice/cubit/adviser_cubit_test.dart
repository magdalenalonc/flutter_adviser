import 'package:flutter_adviser/1_domain/entities/advice_entity.dart';
import 'package:flutter_adviser/1_domain/failures/failures.dart';
import 'package:flutter_adviser/1_domain/usecases/advice_usecases.dart';
import 'package:flutter_adviser/2_application/pages/advice/cubit/adviser_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

class MockAdviceUseCases extends Mock implements AdviceUseCases {}

void main() {
  group('AdviserCubit', () {
    group('should emit', () {
      MockAdviceUseCases mockAdviceUseCases = MockAdviceUseCases();
      blocTest(
        'nothing when no method is called',
        build: () => AdviserCubit(adviceUseCases: mockAdviceUseCases),
        expect: () => const <AdviserCubitState>[],
      );

      blocTest(
        '[AdviserStateLoading, AdviserStateLoaded] when adviceRequestedEvent() is called',
        setUp: () => when(() => mockAdviceUseCases.getAdvice()).thenAnswer(
          (invocation) => Future.value(
            const Right<Failure, AdviceEntity>(
              AdviceEntity(advice: 'advice', id: 13),
            ),
          ),
        ),
        build: () => AdviserCubit(adviceUseCases: mockAdviceUseCases),
        act: (cubit) => cubit.adviceRequestedEvent(),
        expect: () => const <AdviserCubitState>[
          AdviserStateLoading(),
          AdviserStateLoaded(advice: 'advice')
        ],
      );

      group(
          '[AdviserStateLoading, AdviserStateError] when adviceRequestedEvent() is called',
          () {
        blocTest(
          'and a ServerFailure occurs',
          setUp: () => when(() => mockAdviceUseCases.getAdvice()).thenAnswer(
            (invocation) => Future.value(
              Left<Failure, AdviceEntity>(ServerFailure()),
            ),
          ),
          build: () => AdviserCubit(adviceUseCases: mockAdviceUseCases),
          act: (cubit) => cubit.adviceRequestedEvent(),
          expect: () => const <AdviserCubitState>[
            AdviserStateLoading(),
            AdviserStateError(message: serverFailureMessage),
          ],
        );

        blocTest(
          'and a CacheFailure occurs',
          setUp: () => when(() => mockAdviceUseCases.getAdvice()).thenAnswer(
            (invocation) => Future.value(
              Left<Failure, AdviceEntity>(CacheFailure()),
            ),
          ),
          build: () => AdviserCubit(adviceUseCases: mockAdviceUseCases),
          act: (cubit) => cubit.adviceRequestedEvent(),
          expect: () => const <AdviserCubitState>[
            AdviserStateLoading(),
            AdviserStateError(message: cacheFailureMessage),
          ],
        );

        blocTest(
          'and a GeneralFailure occurs',
          setUp: () => when(() => mockAdviceUseCases.getAdvice()).thenAnswer(
            (invocation) => Future.value(
              Left<Failure, AdviceEntity>(GeneralFailure()),
            ),
          ),
          build: () => AdviserCubit(adviceUseCases: mockAdviceUseCases),
          act: (cubit) => cubit.adviceRequestedEvent(),
          expect: () => const <AdviserCubitState>[
            AdviserStateLoading(),
            AdviserStateError(message: generalFailureMessage),
          ],
        );
      });
    });
  });
}
