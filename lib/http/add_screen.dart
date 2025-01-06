import 'package:block_lesson/http/data/data.dart';
import 'package:block_lesson/http/service/service.dart';
import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController avatarController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    avatarController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> addPerson() async {
    if (nameController.text.isNotEmpty &&
        avatarController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty) {
      final person = Person(
        name: nameController.text,
        avatar: avatarController.text,
        description: descriptionController.text,
      );
      await HttpService.createPerson(person);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter the name',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: avatarController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter the avatar',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter the description',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  addPerson();
                },
                child: Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
