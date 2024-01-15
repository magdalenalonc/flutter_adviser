part of 'adviser_cubit.dart';

sealed class AdviserCubitState extends Equatable {
  const AdviserCubitState();

  @override
  List<Object?> get props => [];
}

final class AdviserInitial extends AdviserCubitState {
  const AdviserInitial();
}

final class AdviserStateLoading extends AdviserCubitState {
  const AdviserStateLoading();
}

final class AdviserStateLoaded extends AdviserCubitState {
  const AdviserStateLoaded({required this.advice});
  final String advice;

  @override
  List<Object?> get props => [advice];
}

final class AdviserStateError extends AdviserCubitState {
  const AdviserStateError({required this.message});
  final String message;

  @override
  List<Object?> get props => [message];
}
