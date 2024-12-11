import 'package:bloc/bloc.dart';

class TaskCubit extends Cubit<List<String>> {
  TaskCubit() : super(["1 task", "2 task"]);

  void addTask({required String task}) {
    emit([...state, task]);
  }
}