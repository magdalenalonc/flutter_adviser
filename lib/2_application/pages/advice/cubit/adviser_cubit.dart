import 'package:flutter_adviser/1_domain/entities/advice_entity.dart';
import 'package:flutter_adviser/1_domain/usecases/advice_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'adviser_state.dart';

class AdviserCubit extends Cubit<AdviserCubitState> {
  AdviserCubit() : super(AdviserInitial());
  final AdviceUseCases adviceUseCases = AdviceUseCases();
  // could also use other usecases

  // bloc - has events; cubit - has functions
  void adviceRequestedEvent() async {
    emit(AdviserStateLoading());
    final AdviceEntity advice = await adviceUseCases.getAdvice();

    emit(AdviserStateLoaded(advice: advice.advice));
    // emit(const AdviserStateError(message: 'error message'));
  }
}
