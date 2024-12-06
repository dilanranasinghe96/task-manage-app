import 'package:flutter/material.dart';
import 'package:task_manage_app/services/task_service.dart';

import '../models/tasks.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _desController = TextEditingController();

  final _tasks = Tasks();
  final _taskService = TaskService();

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
              TextButton(
                  onPressed: () {
                    _tasks.title = _titleController.text;
                    _tasks.description = _desController.text;
                    _taskService.saveTask(_tasks);
                  },
                  child: const Text('save'))
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
