// import '../db/get_database.dart';
// import '../models/tasks.dart';

// class TaskService {
//    GetDatabase? _getDatabase;

//   taskService() {
//     _getDatabase = GetDatabase();
//   }

//   Future<int> saveTask(Tasks tasks) async {
//     return await _getDatabase?.insertData('tasks', tasks.taskMap());
//   }
// }


import '../db/get_database.dart';
import '../models/tasks.dart';

class TaskService {
  GetDatabase? _getDatabase;

  TaskService() {
    _getDatabase = GetDatabase();
  }

  // Ensure the return value is always an integer
  Future<int> saveTask(Tasks tasks) async {
    // Safely handle null response
    var result = await _getDatabase?.insertData('tasks', tasks.taskMap()) ?? 0;
    return result;
  }
}
