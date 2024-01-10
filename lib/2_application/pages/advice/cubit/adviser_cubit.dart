import 'package:flutter_adviser/1_domain/failures/failures.dart';
import 'package:flutter_adviser/1_domain/usecases/advice_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'adviser_state.dart';

const generalFailureMessage = 'Ups, something gone wrong. Please try again!';
const serverFailureMessage = 'Ups, API error. Please try egain!';
const cacheFailureMessage = 'Ups, cache failed. Please try egain!';

class AdviserCubit extends Cubit<AdviserCubitState> {
  AdviserCubit() : super(AdviserInitial());
  final AdviceUseCases adviceUseCases = AdviceUseCases();
  // could also use other usecases

  // bloc - has events; cubit - has functions
  void adviceRequestedEvent() async {
    emit(AdviserStateLoading());

    final failureOrAdvice = await adviceUseCases.getAdvice();

    failureOrAdvice.fold(
      (failure) =>
          emit(AdviserStateError(message: _mapFailureToMessage(failure))),
      (advice) => emit(AdviserStateLoaded(advice: advice.advice)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case CacheFailure:
        return cacheFailureMessage;
      default:
        return generalFailureMessage;
    }
  }
}
