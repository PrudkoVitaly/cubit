import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_one_state.dart';

class CounterOneCubit extends Cubit<CounterOneState> {
  CounterOneCubit() : super(CounterOneInitial(count: 0));

  void increment() {
    final currentCounter = (state as CounterOneInitial).count;
    emit(CounterOneInitial(count: currentCounter + 1));
  }
}
