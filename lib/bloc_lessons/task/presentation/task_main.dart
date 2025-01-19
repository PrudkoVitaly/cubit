import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/task_bloc.dart';

class TaskMain extends StatefulWidget {
  const TaskMain({super.key});

  @override
  State<TaskMain> createState() => _TaskMainState();
}

class _TaskMainState extends State<TaskMain> {
  TextEditingController titleController = TextEditingController();
  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final events = context.read<TaskBloc>();
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is TaskLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TaskError) {
              return Center(
                child: Text(state.error),
              );
            } else if (state is TaskSuccess) {
              return ListView.builder(
                itemCount: state.tasks.length,
                itemBuilder: (context, index) {
                  final task = state.tasks[index];
                  return ListTile(
                    title: Text(task),
                    trailing: Row(
                      mainAxisSize:  MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.update),
                          onPressed: () {
                            showDialog(context: context, builder: (context) {
                              final editingController = TextEditingController(text: task);
                              return AlertDialog(
                                title: const Text("Update Task"),
                                content: _textField(controller: editingController),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      events.add(UpdateTaskEvent(index: index, title: editingController.text));
                                      Navigator.pop(context);
                                      editingController.clear();
                                    },
                                    child: const Text("Update"),
                                  ),
                                ],
                              );
                            });

                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            events.add(DeleteTaskEvent(index: index));
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            return const Center(
              child: Text('No data'),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Add Task"),
                  content: _textField(
                    controller: titleController,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        events.add(AddTaskEvent(title: titleController.text));
                        Navigator.pop(context);
                        titleController.clear();
                      },
                      child: const Text("Add"),
                    ),
                  ],
                );
              });
        },
      ),
    );
  }

  Widget _textField({required TextEditingController controller}) {
    return TextField(
      autofocus: true,
      controller: controller,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
    );
  }

  @override
  dispose() {
    titleController.dispose();
    super.dispose();
  }
}
