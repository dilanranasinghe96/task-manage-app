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

  //Insert task data
  insertData(table, data) async {
    var connection = await database;
    return await connection!.insert(table, data);
  }

  //Read tasks data
  readData(table) async {
    var connection = await database;
    return await connection!.query(table);
  }

  readTaskById(table, itemId) async {
    var connection = await database;
    return await connection?.query(table, where: 'id = ?', whereArgs: [itemId]);
  }

  //Update tasks
  updateData(table, data) async {
    var connection = await database;
    return await connection
        ?.update(table, data, where: 'id = ?', whereArgs: [data['id']]);
  }

  //Delete tasks
  deleteData(table, itemId) async {
  var connection = await database;

  return await connection?.rawDelete(
    "DELETE FROM $table WHERE id = ?", 
    [itemId],  
  );
}


}
