import 'package:flutter/material.dart';

import '../database/db_connection.dart';
import '../models/task_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseConnection? databaseConnection;
  late Future<List<TaskModel>> tasksList;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _desController = TextEditingController();

  @override
  void initState() {
    super.initState();
    databaseConnection = DatabaseConnection();
    loadData();
  }

  loadData() async {
    tasksList = databaseConnection!.getTaskList();
  }

  _showFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('cansel')),
              TextButton(onPressed: () async {}, child: const Text('save'))
            ],
            title: const Text(''),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                        hintText: 'Enter title', labelText: 'Title'),
                  ),
                  TextField(
                    controller: _desController,
                    decoration: const InputDecoration(
                        hintText: 'Enter description',
                        labelText: 'Description'),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      body: const Center(
        child: Text('Wecome to tasks page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFormDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
