import 'package:block_lesson/task_one_app/task_one_app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/second_screen.dart';

class TaskOneScreen extends StatefulWidget {
  const TaskOneScreen({super.key});

  @override
  State<TaskOneScreen> createState() => _TaskOneScreenState();
}

class _TaskOneScreenState extends State<TaskOneScreen> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocBuilder<TaskOneAppCubit, TaskOneAppState>(
            builder: (context, state) {
              final currentData = state is TaskOneSuccess ? state.tasks : [];
              if (state is TaskOneAppLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TaskOneError) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(),
                    Text(state.message),
                    IconButton(
                      onPressed: () {
                        context.read<TaskOneAppCubit>().retry();
                      },
                      icon: Icon(Icons.refresh),
                    ),
                  ],
                );
              } else if (state is TaskOneCounterSuccess) {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Counter: ${state.counter}",
                        style: TextStyle(fontSize: 30),
                      ),
                      const Divider(),
                      const SizedBox(height: 10),
                    ]);
              } else {
                return ListView.builder(
                  itemCount: currentData.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          title: Text(currentData[index]),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  updateTaskMethod(
                                      state is TaskOneSuccess
                                          ? state.tasks
                                          : [],
                                      index);
                                },
                                icon: Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () {
                                  context
                                      .read<TaskOneAppCubit>()
                                      .removeTask(task: currentData[index]);
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.read<TaskOneAppCubit>().tryError();
            },
            child: const Icon(Icons.error),
          ),
          const SizedBox(width: 30),
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
                              .read<TaskOneAppCubit>()
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
          const SizedBox(width: 30),
          FloatingActionButton(
            child: const Icon(Icons.add_shopping_cart),
            onPressed: () {
              if (context.read<TaskOneAppCubit>().state
                  is TaskOneCounterSuccess) {
                final currentCounter = (context.read<TaskOneAppCubit>().state
                        as TaskOneCounterSuccess)
                    .counter;
                context
                    .read<TaskOneAppCubit>()
                    .incrementCounter();
              } else {
                context
                    .read<TaskOneAppCubit>()
                    .incrementCounter(); // Инициализация
              }
            },
          ),
          const SizedBox(width: 30),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SecondScreen()));
            },
            child: const Icon(Icons.navigate_next),
          ),
          FloatingActionButton(onPressed: (){
            context.read<TaskOneAppCubit>().incrementCounter();
          }, child: const Icon(Icons.add_card_sharp),)
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
                    .read<TaskOneAppCubit>()
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
