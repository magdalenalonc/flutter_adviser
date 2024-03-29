import 'dart:convert';

import 'package:flutter_adviser/0_data/exceptions/exceptions.dart';
import 'package:flutter_adviser/0_data/models/advice_model.dart';
import 'package:http/http.dart' as http;

abstract class AdviceRemoteDataSource {
  /// requests a random advice from api
  /// returns [AdviceModel] if successful
  /// throws a server - Exception if status code is not 200
  Future<AdviceModel> getRandomAdviceFromApi();
}

class AdviceRemoteDataSourceImpl implements AdviceRemoteDataSource {
  AdviceRemoteDataSourceImpl({required this.client});
  final http.Client client;

  @override
  Future<AdviceModel> getRandomAdviceFromApi() async {
    final response = await client.get(
      Uri.parse('https://api.flutter-community.com/api/v1/advice'),
      // headers are additional informations
      headers: {
        'content-type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw ServerException();
    } else {
      final responseBody = jsonDecode(response.body);

      return AdviceModel.fromJson(responseBody);
    }
  }
}
