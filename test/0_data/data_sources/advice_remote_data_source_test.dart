import 'package:http/http.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_adviser/0_data/data_sources/advice_remote_data_source.dart';
import 'package:flutter_adviser/0_data/models/advice_model.dart';
import 'package:flutter_adviser/0_data/exceptions/exceptions.dart';

import 'advice_remote_data_source_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Client>()])
void main() {
  group('AdviceRemoteDataSource', () {
    group('should return AdviceModel', () {
      test('when Client response was 200 and has valid data', () async {
        final mockClient = MockClient();
        final adviceRemoteDataSourceUnderTest =
            AdviceRemoteDataSourceImpl(client: mockClient);
        const responseBody = '{"advice": "test advice", "advice_id": 1}';

        when(mockClient.get(
          Uri.parse('https://api.flutter-community.com/api/v1/advice'),
          headers: {
            'content-type': 'application/json',
          },
        )).thenAnswer(
          (realInvocation) => Future.value(Response(responseBody, 200)),
        );

        final result =
            await adviceRemoteDataSourceUnderTest.getRandomAdviceFromApi();

        expect(result, AdviceModel(advice: "test advice", id: 1));
      });
    });

    group('should throw', () {
      test('a ServerException when Client response was not 200', () {
        final mockClient = MockClient();
        final adviceRemoteDataSourceUnderTest =
            AdviceRemoteDataSourceImpl(client: mockClient);

        when(mockClient.get(
          Uri.parse('https://api.flutter-community.com/api/v1/advice'),
          headers: {
            'content-type': 'application/json',
          },
        )).thenAnswer(
          (realInvocation) => Future.value(Response('', 201)),
        );

        expect(() => adviceRemoteDataSourceUnderTest.getRandomAdviceFromApi(),
            throwsA(isA<ServerException>()));
      });

      test('a Type Error when Client response was 200 and has no valid data',
          () {
        final mockClient = MockClient();
        final adviceRemoteDataSourceUnderTest =
            AdviceRemoteDataSourceImpl(client: mockClient);
        const responseBody = '{"advice": "test advice"}';

        when(mockClient.get(
          Uri.parse('https://api.flutter-community.com/api/v1/advice'),
          headers: {
            'content-type': 'application/json',
          },
        )).thenAnswer(
          (realInvocation) => Future.value(Response(responseBody, 200)),
        );

        expect(() => adviceRemoteDataSourceUnderTest.getRandomAdviceFromApi(),
            throwsA(isA<TypeError>()));
      });
    });
  });
}
