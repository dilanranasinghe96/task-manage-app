import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

//Create database connection
class DatabaseConnection {
  setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'tasks_db');
    var database =
        await openDatabase(path, version: 1, onCreate: _onCreatingDatabase);
    return database;
  }

  //Create database
  _onCreatingDatabase(Database database, int version) async {
    await database.execute(
        "CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTO INCREMENT,title TEXT,description TEXT)");
  }
}
