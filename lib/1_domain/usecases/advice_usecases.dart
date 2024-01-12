import 'package:dartz/dartz.dart';
import 'package:flutter_adviser/1_domain/entities/advice_entity.dart';
import 'package:flutter_adviser/1_domain/failures/failures.dart';
import 'package:flutter_adviser/1_domain/repositories/advice_repo.dart';

class AdviceUseCases {
  AdviceUseCases({required this.adviceRepo});
  final AdviceRepo adviceRepo;

  // Failure -> left; AdviceEntity -> right
  Future<Either<Failure, AdviceEntity>> getAdvice() async {
    return adviceRepo.getAdviceFromDataSource();
    // space for business logic
  }
}
