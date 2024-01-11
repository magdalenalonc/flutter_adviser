import 'package:dartz/dartz.dart';
import 'package:flutter_adviser/0_data/repositories/advice_repo_impl.dart';
import 'package:flutter_adviser/1_domain/entities/advice_entity.dart';
import 'package:flutter_adviser/1_domain/failures/failures.dart';

class AdviceUseCases {
  final adviceRepo = AdviceRepoImpl();
  // Failure -> left; AdviceEntity -> right
  Future<Either<Failure, AdviceEntity>> getAdvice() async {
    return adviceRepo.getAdviceFromDataSource();
    // space for business logic
  }
}