import 'package:block_lesson/hive_app/models/item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/item_cubit.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen({super.key});

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController valueController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ItemCubit, ItemState>(
          builder: (BuildContext context, state) {
            if (state is ItemInitial) {
              return const Center(
                child: Text("No Items"),
              );
            } else if (state is ItemLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ItemError) {
              return Center(
                child: Text(state.message),
              );
            } else if (state is ItemSuccess) {
              return ListView.builder(
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.items[index].title),
                    subtitle: Text(state.items[index].value.toString()),
                  );
                },
              );
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Add Item"),
              content: SizedBox(
                height: 150,
                child: Column(
                  children: [
                    TextField(
                      autofocus: true,
                      controller: titleController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Title",
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      autofocus: true,
                      controller: valueController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Value",
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    final item = ItemModel(
                      id: DateTime.now().toString(),
                      title: titleController.text,
                      value: int.parse(valueController.text),
                    );
                    context.read<ItemCubit>().addItem(value: item);
                    titleController.clear();
                    valueController.clear();
                    Navigator.pop(context);
                  },
                  child: Text("Add Item"),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Update Item Method
// Delete Item Method
// Filter Item Method (value)
// Search Item Method (title)

// Перед удалением или обновлением спрашивать у пользователя
