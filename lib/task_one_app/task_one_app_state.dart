part of 'task_one_app_cubit.dart';

@immutable
sealed class TaskOneAppState {
  get tasks => null;
}

final class TaskOneAppLoading extends TaskOneAppState {}

final class TaskOneError extends TaskOneAppState {
  final String message;

  TaskOneError({this.message = "Произошла ошибка"});
}

final class TaskOneSuccess extends TaskOneAppState {
  final List<String> tasks;

  TaskOneSuccess({required this.tasks});

}

final class TaskAddSuccess extends TaskOneAppState {
  final List<String> newTasks;

  TaskAddSuccess({required this.newTasks});
}

final class TaskOneCounterSuccess extends TaskOneAppState {
  final int counter;

  TaskOneCounterSuccess({this.counter = 1});
}


