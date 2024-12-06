import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/task_model.dart';

class DatabaseConnection {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return null;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'task_DB');
    var db = await openDatabase(path, version: 1, onCreate: _createDatabase);
    return db;
  }

  _createDatabase(Database db, int version) async {
    await db.execute(
        "CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT NOT NULL,desc TEXT NOT NULL,dataAndTime TEXT NOT NULL)");
  }

  Future<TaskModel> insert(TaskModel taskModel) async {
    var dbClient = await db;
    await dbClient?.insert('tasks', taskModel.toMap());
    return taskModel;
  }

  Future<List<TaskModel>> getTaskList() async {
    await db;
    final List<Map<String, Object?>> QueryResult =
        await _db!.rawQuery("SELECT * FROM tasks");
    return QueryResult.map((e) => TaskModel.fromMap(e)).toList();
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient!.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(TaskModel taskModel) async {
    var dbClient = await db;
    return await dbClient!.update('tasks', taskModel.toMap(),
        where: 'id = ?', whereArgs: [taskModel.id]);
  }
}
