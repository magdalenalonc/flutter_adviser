import 'package:dartz/dartz.dart';
import 'package:flutter_adviser/0_data/data_sources/advice_remote_data_source.dart';
import 'package:flutter_adviser/0_data/exceptions/exceptions.dart';
import 'package:flutter_adviser/1_domain/entities/advice_entity.dart';
import 'package:flutter_adviser/1_domain/failures/failures.dart';
import 'package:flutter_adviser/1_domain/repositories/advice_repo.dart';

class AdviceRepoImpl implements AdviceRepo {
  AdviceRepoImpl({required this.adviceRemoteDataSource});
  final AdviceRemoteDataSource adviceRemoteDataSource;

  @override
  Future<Either<Failure, AdviceEntity>> getAdviceFromDataSource() async {
    try {
      final result = await adviceRemoteDataSource.getRandomAdviceFromApi();
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      // handle the exception
      return left(GeneralFailure());
    }
  }
}
