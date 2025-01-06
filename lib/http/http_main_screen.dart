import 'package:block_lesson/http/service/service.dart';
import 'package:flutter/material.dart';

import 'data/data.dart';

class HttpMainScreen extends StatefulWidget {
  const HttpMainScreen({super.key});

  @override
  State<HttpMainScreen> createState() => _HttpMainScreenState();
}

class _HttpMainScreenState extends State<HttpMainScreen> {
  late final HttpService httpService;
  late final Future<List<Person>> future;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController avatarController = TextEditingController();

  @override
  void initState() {
    httpService = HttpService();
    future = httpService.getData();
    super.initState();
  }

  void refresh() {
    setState(() {
      future = httpService.getData();
    });
  }

  Future<void> deleteData(String id) async {
    await httpService.deleteData(id);
    refresh();
    setState(() {});
  }

  Future<void> updateData(String id) async {
    if (nameController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        avatarController.text.isNotEmpty) {
      final updatePerson = Person(
        name: nameController.text,
        avatar: avatarController.text,
        description: descriptionController.text,
      );
      await HttpService.updatePerson(id, updatePerson);
    }
  }

  void myShowDialog(String id) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              TextButton(
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: const Text("Add"),
                onPressed: () {
                  updateData(id);
                  Navigator.pop(context);
                },
              ),
            ],
            title: const Text("Add Task"),
            content: SizedBox(
              height: 300,
              width: 300,
              child: Column(
                children: [
                  _textField(
                    title: 'Name',
                    controller: nameController,
                  ),
                  const SizedBox(height: 20),
                  _textField(
                    title: 'Description',
                    controller: descriptionController,
                  ),
                  const SizedBox(height: 20),
                  _textField(
                    title: 'Avatar',
                    controller: avatarController,
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _textField(
      {required String title, required TextEditingController controller}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: title,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text('No data'),
            );
          }
          final data = snapshot.data!;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final person = data[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(person.avatar),
                ),
                title: Text(person.name),
                subtitle: Text(person.description),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        myShowDialog(person.id!);
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        await httpService.deleteData(person.id!);
                        refresh();
                        setState(() {});
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
