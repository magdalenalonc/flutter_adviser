import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'adviser_state.dart';

class AdviserCubit extends Cubit<AdviserCubitState> {
  AdviserCubit() : super(AdviserInitial());

  // bloc - has events; cubit - has functions
  void adviceRequestedEvent() async {
    emit(AdviserStateLoading());
    // execute business logic, for example get and advice
    debugPrint('fake get advice triggered');
    await Future.delayed(const Duration(seconds: 3), () {});
    debugPrint('got advice');

    // emit(AdviserStateLoaded(advice: 'fake advice to test bloc'));

    emit(const AdviserStateError(message: 'error message'));
  }
}
