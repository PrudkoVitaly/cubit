part of 'task_bloc.dart';

sealed class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

final class TaskInitial extends TaskState {}

final class TaskLoading extends TaskState {}

final class TaskSuccess extends TaskState {
  final List<String> tasks;

  const TaskSuccess({required this.tasks});

  @override
  List<Object> get props => [tasks];
}

final class TaskError extends TaskState {
  final String error;

  const TaskError({required this.error});

  @override
  List<Object> get props => [error];
}
