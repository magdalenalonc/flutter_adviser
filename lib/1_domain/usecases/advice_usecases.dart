import 'package:flutter_adviser/1_domain/entities/advice_entity.dart';

class AdviceUseCases {
  Future<AdviceEntity> getAdvice() async {
    // call a repository to get data (faiulure or data)
    // proceed with business logic (manipulate the data)
    await Future.delayed(const Duration(seconds: 3), () {});
    return const AdviceEntity(advice: 'fake advice to test', id: 1);
  }
}
