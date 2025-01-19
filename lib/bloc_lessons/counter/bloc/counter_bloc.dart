import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_event.dart';

part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState(counter: 0)) {
    on<CounterIncrementEvent>((event, emit) {
      emit(CounterState(counter: state.counter + 1));
    });
    on<CounterDecrementEvent>((event, emit) {
      if (state.counter == 0) return;
      emit(CounterState(counter: state.counter -event.decrementValue));
    });
    on<CounterResetEvent>((event, emit) {
      emit(const CounterState(counter: 0));
    });
  }
}
