import 'package:bloc/bloc.dart';


class TaskCubit extends Cubit<List<String>> {
  TaskCubit() : super(["1 task", "2 task"]);

  void addTask({required String task}) {
    emit([...state, task]);
  }

  void removeTask({required String task}) {
    emit([...state]..remove(task));
  }

  void updateTask({required String task, required String newTask}) {
    emit([...state]..remove(task)..insert(state.indexOf(task), newTask));
  }

  void clearTask() {
    emit([ ]);
  }

  void reorderTasks(int oldIndex, int newIndex) {
    final tasks = List<String>.from(state);
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final item = tasks.removeAt(oldIndex);
    tasks.insert(newIndex, item);
    emit(tasks);
  }
}
