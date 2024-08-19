import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_management/models/task_model.dart';

class DatabaseHelper {
  static const String dbName = "myDatabase.db";
  static const int dbVersion = 1;
  static const String tableName = "tasks";
  static const String id = "id";
  static const String title = "title";
  static const String description = "description";
  static const String status = "status";
  static const String createdDate = "createdDate";
  static const String dueDate = "dueDate";

  static final DatabaseHelper instance = DatabaseHelper();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await initDB();

    return _database;
  }

  initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);
    return await openDatabase(path, version: dbVersion, onCreate: onCreate);
  }

  Future onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE tasks(
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $title TEXT,
      $description TEXT,
      $status INTEGER,
      $createdDate TEXT,
      $dueDate TEXT
    )
  ''');
  }

  Future<int> insertTask(TaskModel task) async {
    Database? db = await instance.database;
    return await db!.insert(tableName, task.toMap());
  }

  Future<List<TaskModel>> fetchTasks() async {
    Database? db = await instance.database;
    final List<Map<String, dynamic>> maps = await db!.query(tableName);
    return List.generate(maps.length, (i) {
      return TaskModel.fromMapObject(maps[i]);
    });
  }

  Future<int> updateTask(TaskModel task) async {
    Database? db = await instance.database;
    return await db!.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> deleteTask(int id) async {
    Database? db = await instance.database;
    return await db!.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
