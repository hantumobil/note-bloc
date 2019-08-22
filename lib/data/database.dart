import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  initDB() async {
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String path = join(documentsDir.path, 'app.db');

    return openDatabase(
      path,
      version: 1,
      onOpen: (db) async {
        // code when open
      },
      onCreate: (Database db, int version) async {
        await db.execute('''
      CREATE TABLE note(
        id INTEGER PRIMARY KEY,
        contents TEXT DEFAULT ''
      )
      ''');
      },
    );
  }

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDB();
    return _database;
  }
}
