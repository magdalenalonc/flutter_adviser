import 'package:dartz/dartz.dart';
import 'package:flutter_adviser/1_domain/entities/advice_entity.dart';
import 'package:flutter_adviser/1_domain/failures/failures.dart';

class AdviceUseCases {
  // Failure -> left; AdviceEntity -> right
  Future<Either<Failure, AdviceEntity>> getAdvice() async {
    // call a repository to get data (faiulure or data)
    // proceed with business logic (manipulate the data)
    await Future.delayed(const Duration(seconds: 3), () {});

    // call to repo went good -> return data, not failure (right of Either)
    // return right(const AdviceEntity(advice: 'fake advice to test', id: 1));

    // call to repo went bad (or logic had an error) -> return failure (left of Either)
    return left(CacheFailure());
  }
}
