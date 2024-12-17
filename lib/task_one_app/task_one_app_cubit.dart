import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'task_one_app_state.dart';

class TaskOneAppCubit extends Cubit<TaskOneAppState> {
  TaskOneAppCubit()
      : super(TaskOneSuccess(tasks: ['Task 1', 'Task 2', 'Task 3'])) {
    getData();
  }

  Future<void> getData() async {
    emit(TaskOneAppLoading());
    await Future.delayed(const Duration(seconds: 2));
    emit(
      TaskOneSuccess(
        tasks: ['Task 1', 'Task 2', 'Task 3'],
      ),
    );
  }

  void addTask({required String task}) {
    emit(TaskOneSuccess(tasks: [...state.tasks, task]));
  }

  void removeTask({required String task}) {
    emit(TaskOneSuccess(tasks: [...state.tasks]..remove(task)));
  }

  void updateTask({required String task, required String newTask}) {
    emit(TaskOneSuccess(
        tasks: [...state.tasks]
          ..remove(task)
          ..insert(state.tasks.indexOf(task), newTask)));
  }

  void incrementCounter() {
    final currentCounter = (state as TaskOneCounterSuccess).counter;
    emit(TaskOneCounterSuccess(counter: currentCounter + 1));
  }



  void tryError() {
    emit(TaskOneError());
  }

  void retry() {
    getData();
  }
}
