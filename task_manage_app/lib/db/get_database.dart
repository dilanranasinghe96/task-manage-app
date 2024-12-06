import 'package:sqflite/sqflite.dart';
import 'package:task_manage_app/db/database_connection.dart';

class GetDatabase {
  DatabaseConnection? _databaseConnection;

  GetDatabase() {
    _databaseConnection = DatabaseConnection();
  }

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _databaseConnection!.setDatabase();
    return _database;
  }

  insertData(table, data) async {
    var connection = await database;
    return await connection!.insert(table, data);
  }
}
