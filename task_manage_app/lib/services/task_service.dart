import '../db/get_database.dart';
import '../models/tasks.dart';

class TaskService {
  GetDatabase? _getDatabase;

  TaskService() {
    _getDatabase = GetDatabase();
  }

  Future<int> saveTask(Tasks tasks) async {
    return await _getDatabase?.insertData('tasks', tasks.taskMap()) ??
        Future.error('Database not initialized');
  }

  readTasks() async {
    return await _getDatabase?.readData('tasks');
  }

  readTaskById(taskId) async {
    return await _getDatabase?.readTaskById('tasks', taskId);
  }

  updateTask(Tasks tasks) async {
    return await _getDatabase?.updateData('tasks', tasks.taskMap());
  }

 deleteTask(Tasks task) async {
  return await _getDatabase?.deleteData('tasks', task.id);  
}


}
