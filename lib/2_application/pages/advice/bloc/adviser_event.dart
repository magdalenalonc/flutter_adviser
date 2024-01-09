part of 'adviser_bloc.dart';

@immutable
sealed class AdviserEvent {}

class AdviceRequestedEvent extends AdviserEvent {}