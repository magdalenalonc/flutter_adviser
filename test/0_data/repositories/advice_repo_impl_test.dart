import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_adviser/0_data/exceptions/exceptions.dart';
import 'package:flutter_adviser/1_domain/entities/advice_entity.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_adviser/0_data/data_sources/advice_remote_data_source.dart';
import 'package:flutter_adviser/0_data/models/advice_model.dart';
import 'package:flutter_adviser/0_data/repositories/advice_repo_impl.dart';
import 'package:flutter_adviser/1_domain/failures/failures.dart';

import 'advice_repo_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AdviceRemoteDataSourceImpl>()])
void main() {
  group('AdviceRepoImpl', () {
    group('should return AdviceEntity', () {
      test('when AdviceRemoteDataSource returns an AdviceModel', () async {
        final mockAdviceRemoteDataSource = MockAdviceRemoteDataSourceImpl();
        final adviceRepoImplUnderTest =
            AdviceRepoImpl(adviceRemoteDataSource: mockAdviceRemoteDataSource);

        when(mockAdviceRemoteDataSource.getRandomAdviceFromApi()).thenAnswer(
          (realInvocation) => Future.value(AdviceModel(advice: 'test', id: 13)),
        );

        final result = await adviceRepoImplUnderTest.getAdviceFromDataSource();

        expect(result.isLeft(), false);
        expect(result.isRight(), true);
        expect(result,
            Right<Failure, AdviceModel>(AdviceModel(advice: 'test', id: 13)));
        verify(mockAdviceRemoteDataSource.getRandomAdviceFromApi()).called(1);
        verifyNoMoreInteractions(mockAdviceRemoteDataSource);
      });
    });

    group('should return left with', () {
      test('a ServerFailure when a ServerException occurs', () async {
        final mockAdviceRemoteDataSource = MockAdviceRemoteDataSourceImpl();
        final adviceRepoImplUnderTest =
            AdviceRepoImpl(adviceRemoteDataSource: mockAdviceRemoteDataSource);

        when(mockAdviceRemoteDataSource.getRandomAdviceFromApi())
            .thenThrow(ServerException());

        final result = await adviceRepoImplUnderTest.getAdviceFromDataSource();

        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failure, AdviceEntity>(ServerFailure()));
      });

      test('a GeneralFailure on all other Exceptions', () async {
        final mockAdviceRemoteDataSource = MockAdviceRemoteDataSourceImpl();
        final adviceRepoImplUnderTest =
            AdviceRepoImpl(adviceRemoteDataSource: mockAdviceRemoteDataSource);

        when(mockAdviceRemoteDataSource.getRandomAdviceFromApi())
            .thenThrow(const SocketException('test'));

        final result = await adviceRepoImplUnderTest.getAdviceFromDataSource();

        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failure, AdviceEntity>(GeneralFailure()));
      });
    });
  });
}
