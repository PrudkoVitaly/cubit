import 'package:block_lesson/task_app/task_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<TaskCubit, List<String>>(
          builder: (context, state) {
            return ReorderableListView(
              onReorder: (oldIndex, newIndex) {
                context.read<TaskCubit>().reorderTasks(oldIndex, newIndex);
              },
              children: [
                for (int index = 0; index < state.length; index++)
                  ListTile(
                    key: ValueKey(index),
                    tileColor: index % 2 == 0 ? Colors.blue[50] : Colors.white,
                    title: Text(
                      state[index],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.update),
                          onPressed: () {
                            updateTaskMethod(state, index);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete_forever),
                          onPressed: () {
                            context
                                .read<TaskCubit>()
                                .removeTask(task: state[index]);
                          },
                        )
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Floating Button Add
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Add Task"),
                    content: TextField(
                      autofocus: true,
                      controller: controller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          context
                              .read<TaskCubit>()
                              .addTask(task: controller.text);
                          controller.clear();
                          Navigator.pop(context);
                        },
                        child: const Text("Add"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          // Floating Button Remove
          FloatingActionButton(
            child: const Icon(Icons.remove),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Remove Task"),
                    content: TextField(
                      autofocus: true,
                      controller: controller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          context
                              .read<TaskCubit>()
                              .removeTask(task: controller.text);
                          controller.clear();
                          Navigator.pop(context);
                        },
                        child: const Text("Remove"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          // Floating Button Clear
          FloatingActionButton(
            child: const Icon(Icons.clear),
            onPressed: () {
              context.read<TaskCubit>().clearTask();
            },
          ),
        ],
      ),
    );
  }

  // Update Task Method
  Future<dynamic> updateTaskMethod(List<String> state, int index) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Task"),
          content: TextField(
            autofocus: true,
            controller: controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                context
                    .read<TaskCubit>()
                    .updateTask(task: state[index], newTask: controller.text);
                controller.clear();
                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }
}
