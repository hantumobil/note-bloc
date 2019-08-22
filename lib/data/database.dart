import 'dart:io';
import 'package:note_block/models/note_model.dart';
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

  /*
   * Note Table
   */
  newNote(Note note) async {
    final db = await database;
    var res = await db.insert('note', note.toJson());

    return res;
  }

  getNotes() async {
    final db = await database;
    var res = await db.query('note');
    List<Note> notes =
        res.isNotEmpty ? res.map((note) => Note.fromJSON(note)).toList() : [];
    return notes;
  }

  getNote(int id) async {
    final db = await database;
    return await db.query(
      'note',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  updateNode(Note note) async {
    final db = await database;
    return await db.update('note', note.toJson());
  }

  deleteNote(int id) async {
    final db = await database;
    return db.delete(
      'node',
      whereArgs: [id],
      where: 'id = ?',
    );
  }
}
