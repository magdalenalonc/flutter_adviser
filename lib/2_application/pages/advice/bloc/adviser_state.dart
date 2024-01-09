part of 'adviser_bloc.dart';

@immutable
sealed class AdviserState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class AdviserInitial extends AdviserState {}

final class AdviserStateLoading extends AdviserState {}

final class AdviserStateLoaded extends AdviserState {
  AdviserStateLoaded({required this.advice});
  final String advice;

  @override
  List<Object?> get props => [advice];
}

final class AdviserStateError extends AdviserState {
  AdviserStateError({required this.message});
  final String message;

  @override
  List<Object?> get props => [message];
}
