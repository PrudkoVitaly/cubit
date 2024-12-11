import 'package:bloc/bloc.dart';

class StringCubit extends Cubit<String> {
  StringCubit() : super("hello");

  void changeString() {
    emit(state.toUpperCase());
  }
}