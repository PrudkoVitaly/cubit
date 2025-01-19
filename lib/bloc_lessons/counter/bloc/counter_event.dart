part of 'counter_bloc.dart';

sealed class CounterEvent extends Equatable {
  const CounterEvent();

  @override
  List<Object?> get props => [];
}

class CounterIncrementEvent extends CounterEvent {}

class CounterDecrementEvent extends CounterEvent {
  final int decrementValue;

  const CounterDecrementEvent({required this.decrementValue});

  @override
  // TODO: implement props
  List<Object?> get props => [decrementValue];
}

class CounterResetEvent extends CounterEvent {}
