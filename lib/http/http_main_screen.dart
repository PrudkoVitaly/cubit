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
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      await httpService.deleteData(person.id);
                      refresh();
                      setState(() {});
                    },
                  ),
                );
              });
        },
      ),
    );
  }
}
