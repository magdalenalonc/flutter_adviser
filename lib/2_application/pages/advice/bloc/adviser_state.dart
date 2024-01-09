part of 'adviser_bloc.dart';

@immutable
sealed class AdviserState {}

final class AdviserInitial extends AdviserState {}

final class AdviserStateLoading extends AdviserState {}

final class AdviserStateLoaded extends AdviserState {
  AdviserStateLoaded({required this.advice});
  final String advice;
}

final class AdviserStateError extends AdviserState {
  AdviserStateError({required this.message});
  final String message;
}
