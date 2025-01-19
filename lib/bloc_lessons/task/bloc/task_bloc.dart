import 'package:bloc/bloc.dart';
import 'package:block_lesson/bloc_lessons/task/data/data.dart';
import 'package:equatable/equatable.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    on<FetchTasksEvent>(_onFetchData);
    on<AddTaskEvent>(_onAddTask);
    on<DeleteTaskEvent>(_onDeleteTask);
    on<UpdateTaskEvent>(_onUpdateTask);
  }

  Future<void> _onFetchData(
      FetchTasksEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));
      final tasks = tasksData;
      if (tasks.isNotEmpty) {
        emit(TaskSuccess(tasks: tasks));
      } else {
        emit(const TaskError(error: "No data found"));
      }
    } catch (e) {
      emit(TaskError(
          error: "Произошла ошибка при загрузке данных FetchTasksEvent $e"));
    }
  }

  void _onAddTask(AddTaskEvent event, Emitter<TaskState> emit) {
    {
      try {
        final currentTask =
            state is TaskSuccess ? (state as TaskSuccess).tasks : [];
        final updatedTask = List<String>.from(currentTask)..add(event.title);
        emit(TaskSuccess(tasks: updatedTask));
      } catch (e) {
        emit(TaskError(error: "Не смогли добавить задачу $e"));
      }
    }
  }

  void _onDeleteTask(DeleteTaskEvent event, Emitter<TaskState> emit) {
    try {
      if (state is TaskSuccess) {
        final currentTask = (state as TaskSuccess).tasks;
        final updatedTask = List<String>.from(currentTask)
          ..removeAt(event.index);
        emit(TaskSuccess(tasks: updatedTask));
      }
    } catch (e) {
      emit(TaskError(error: "Не смогли удалить задачу $e"));
    }
  }

  void _onUpdateTask(UpdateTaskEvent event, Emitter<TaskState> emit) {
    try {
      if (state is TaskSuccess) {
        final currentTask = (state as TaskSuccess).tasks;
        final updatedTask = List<String>.from(currentTask)..[event.index] = event.title;

        emit(TaskSuccess(tasks: updatedTask));
      }
    } catch (e) {
      emit(TaskError(error: "Не смогли обновить задачу $e"));
    }
  }
}
