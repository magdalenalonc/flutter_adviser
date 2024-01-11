import 'package:dartz/dartz.dart';
import 'package:flutter_adviser/0_data/data_sources/advice_remote_data_source.dart';
import 'package:flutter_adviser/1_domain/entities/advice_entity.dart';
import 'package:flutter_adviser/1_domain/failures/failures.dart';
import 'package:flutter_adviser/1_domain/repositories/advice_repo.dart';

class AdviceRepoImpl implements AdviceRepo {
  final AdviceRemoteDataSource adviceRemoteDataSource =
      AdviceRemoteDataSourceImpl();
  @override
  Future<Either<Failure, AdviceEntity>> getAdviceFromDataSource() async {
    final result = await adviceRemoteDataSource.getRandomAdviceFromApi();
    return right(result);
  }
}
