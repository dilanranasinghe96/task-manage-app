import 'package:flutter/material.dart';
import 'package:task_manage_app/components/custom_text.dart';
import 'package:task_manage_app/screens/task_details_page.dart';
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

  final TextEditingController _editTitleController = TextEditingController();
  final TextEditingController _editDesController = TextEditingController();

  final _tasks = Tasks();
  final _taskService = TaskService();

  List<Tasks> _taskList = [];

  @override
  void initState() {
    super.initState();
    getAllTasks();
  }

  getAllTasks() async {
    _taskList = [];
    var tasks = await _taskService.readTasks();
    tasks.forEach((task) {
      setState(() {
        var taskModel = Tasks();
        taskModel.title = task['title'];
        taskModel.description = task['description'];
        taskModel.id = task['id'];
        _taskList.add(taskModel);
      });
    });
  }

  editTask(BuildContext context, taskId) async {
    var task = await _taskService.readTaskById(taskId);

    setState(() {
      _editTitleController.text = task[0]['title'] ?? "No Title";
      _editDesController.text = task[0]['description'] ?? "No Description";
    });

    _editFormDialog(context, task[0]['id']);
  }

  // Show the add task dialog
  _showFormDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (param) {
        return AlertDialog(
          actions: <Widget>[
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel')),
            TextButton(
                onPressed: () async {
                  if (_titleController.text.isEmpty ||
                      _desController.text.isEmpty) {
                    print('Title or description cannot be empty');
                    return;
                  }

                  _tasks.title = _titleController.text;
                  _tasks.description = _desController.text;
                  var result = await _taskService.saveTask(_tasks);
                  print(result);

                  getAllTasks();
                  _titleController.clear();
                  _desController.clear();
                  Navigator.pop(context);
                },
                child: const Text('Save'))
          ],
          title: const Text('Add New Task'),
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
                      hintText: 'Enter description', labelText: 'Description'),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  // Show the edit form dialog
  _editFormDialog(BuildContext context, int taskId) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (param) {
        return AlertDialog(
          actions: <Widget>[
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel')),
            TextButton(
                onPressed: () async {
                  if (_editTitleController.text.isEmpty ||
                      _editDesController.text.isEmpty) {
                    print('Title or description cannot be empty');
                    return;
                  }
                  _tasks.id = taskId;
                  _tasks.title = _editTitleController.text;
                  _tasks.description = _editDesController.text;

                  var result = await _taskService.updateTask(_tasks);
                  if (result > 0) {
                    print('Task updated');
                    getAllTasks();

                    Navigator.pop(context);
                  }
                },
                child: const Text('Update'))
          ],
          title: const Text('Edit Task'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _editTitleController,
                  decoration: const InputDecoration(
                      hintText: 'Enter title', labelText: 'Title'),
                ),
                TextField(
                  controller: _editDesController,
                  decoration: const InputDecoration(
                      hintText: 'Enter description', labelText: 'Description'),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  // show delete dialog
  _deleteFormDialog(BuildContext context, Tasks task) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (param) {
        return AlertDialog(
          actions: <Widget>[
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel')),
            TextButton(
                onPressed: () async {
                  var result = await _taskService.deleteTask(task);
                  if (result > 0) {
                    print('Task deleted');
                    getAllTasks();
                    Navigator.pop(context);
                  }
                },
                child: const Text('Delete'))
          ],
          title: const Text('Delete Task'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade100,
      appBar: AppBar(
          backgroundColor: Colors.amber.shade300,
          automaticallyImplyLeading: false,
          title: CustomText(
              text: 'Tasks',
              color: Colors.black,
              fsize: 25,
              fweight: FontWeight.bold)),
      body: ListView.builder(
        itemCount: _taskList.length,
        itemBuilder: (context, index) {
          var task = _taskList[index];
          return Card(
            color: Colors.amber.shade200,
            child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskDetailsPage(
                          title: task.title ?? 'No Title',
                          description: task.description ?? 'No Description',
                        ),
                      ));
                },
                trailing: IconButton(
                    onPressed: () {
                      _deleteFormDialog(context, task);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    )),
                leading: IconButton(
                  onPressed: () {
                    editTask(context, _taskList[index].id);
                  },
                  icon: const Icon(Icons.edit),
                ),
                title: CustomText(
                    text: task.title ?? 'No Title',
                    color: Colors.black,
                    fsize: 20,
                    fweight: FontWeight.w400)),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber.shade300,
        onPressed: () {
          _showFormDialog(context);
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}
