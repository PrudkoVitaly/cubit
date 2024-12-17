part of 'counter_one_cubit.dart';

@immutable
sealed class CounterOneState {}

final class CounterOneInitial extends CounterOneState {
  final int count;
  CounterOneInitial({required this.count});
}
