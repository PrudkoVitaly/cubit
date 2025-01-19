part of 'task_bloc.dart';

sealed class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

final class FetchTasksEvent extends TaskEvent {}

final class AddTaskEvent extends TaskEvent {
  final String title;

  const AddTaskEvent({required this.title});

  @override
  List<Object> get props => [title];
}

final class DeleteTaskEvent extends TaskEvent {
  final int index;

  const DeleteTaskEvent({required this.index});

  @override
  List<Object> get props => [index];
}

final class UpdateTaskEvent extends TaskEvent {
  final int index;
  final String title;

  const UpdateTaskEvent({required this.index, required this.title});

  @override
  List<Object> get props => [index, title];
}
