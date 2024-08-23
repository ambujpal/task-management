import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_management/models/task_model.dart';
import 'package:task_management/models/user_model.dart';

class DatabaseHelper {
  static const String dbName = "myDatabase.db";
  static const int dbVersion = 1;

  // tasks table
  static const String tableName = "tasks";
  static const String id = "id";
  static const String title = "title";
  static const String description = "description";
  static const String status = "status";
  static const String createdDate = "createdDate";
  static const String dueDate = "dueDate";

  // User table
  static const String userTable = "users";
  static const String userId = "userId";
  static const String userName = "userName";
  static const String userPassword = "userPassword";

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

    await db.execute('''
      CREATE TABLE $userTable(
        $userId INTEGER PRIMARY KEY AUTOINCREMENT,
        $userName TEXT UNIQUE,
        $userPassword TEXT
      )
    ''');
  }

  //Login Method

  Future<bool> login(Users user) async {
    final Database db = await initDB();

    // I forgot the password to check
    var result = await db.rawQuery(
        "select * from users where userName = '${user.userName}' AND userPassword = '${user.userPassword}'");
    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  //Sign up
  Future<int> signup(Users user) async {
    Database? db = await instance.database;

    return db!.insert('users', user.toMap());
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
