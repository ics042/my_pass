import 'dart:async';
import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  static final AppDatabase _appDatabase = AppDatabase._internal();

  static const String dbName = 'my_pass';
  Database db;

  factory AppDatabase() {
    return _appDatabase;
  }

  Future init() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, dbName);

    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (e) {
      print(e);
    }
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute("CREATE TABLE pass ("
          "id STRING PRIMARY KEY,"
          "description TEXT,"
          "pwd TEXT"
          ")");
    });
  }

  AppDatabase._internal();
}
