// import 'package:flutter/material.dart';
// import 'package:task_manage_app/services/task_service.dart';

// import '../models/tasks.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _desController = TextEditingController();

//   final _tasks = Tasks();
//   final _taskService = TaskService();

//   _showFormDialog(BuildContext context) {
//     return showDialog(
//         context: context,
//         barrierDismissible: true,
//         builder: (param) {
//           return AlertDialog(
//             actions: <Widget>[
//               TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: const Text('cansel')),
//               TextButton(
//                   onPressed: () async {
//                     _tasks.title = _titleController.text;
//                     _tasks.description = _desController.text;
//                     var result = await _taskService.saveTask(_tasks);
//                     print(result);
//                   },
//                   child: const Text('save'))
//             ],
//             title: const Text(''),
//             content: SingleChildScrollView(
//               child: Column(
//                 children: <Widget>[
//                   TextField(
//                     controller: _titleController,
//                     decoration: const InputDecoration(
//                         hintText: 'Enter title', labelText: 'Title'),
//                   ),
//                   TextField(
//                     controller: _desController,
//                     decoration: const InputDecoration(
//                         hintText: 'Enter description',
//                         labelText: 'Description'),
//                   )
//                 ],
//               ),
//             ),
//           );
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Tasks'),
//       ),
//       body: const Center(
//         child: Text('Wecome to tasks page'),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _showFormDialog(context);
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

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

  // Show the form dialog to add a new task
  _showFormDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (param) {
        return AlertDialog(
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (_titleController.text.isEmpty ||
                    _desController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Title and Description are required!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  return;
                }

                // Save the task
                _tasks.title = _titleController.text;
                _tasks.description = _desController.text;
                var result = await _taskService.saveTask(_tasks);

                if (result > 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Task added successfully!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Failed to add task!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }

                // Clear text fields and close dialog
                _titleController.clear();
                _desController.clear();
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
          title: const Text('Add New Task'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    hintText: 'Enter title',
                    labelText: 'Title',
                  ),
                ),
                TextField(
                  controller: _desController,
                  decoration: const InputDecoration(
                    hintText: 'Enter description',
                    labelText: 'Description',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      body: const Center(
        child: Text('Welcome to tasks page'),
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
