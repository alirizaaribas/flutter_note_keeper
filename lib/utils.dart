import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:note_keeper/note.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  static Database _database;
  String tablaName = 'note_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colDate = 'date';
  String colPriority = 'priority';

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }

  Future<Database> initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'notes.db';

    var notesDb = await openDatabase(path, version: 1, onCreate: _createDb);
  }

  void _createDb(Database db, int version) async {
    await db.execute(
        'create table $tablaName($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colDescription TEXT, $colDate TEXT, $colPriority INTEGER);');
  }

  Future<List<Map<String, dynamic>>> getNoteList() async {
    Database db = await this.database;
    var result = await db.query(tablaName, orderBy: "$colPriority asc");
    return result;
  }

  Future<int> insert(Note note) async {
    Database db = await this.database;
    var result = await db.insert(tablaName, note.toMap());
    return result;
  }

  Future<int> update(Note note) async {
    Database db = await this.database;
    var result = await db.update(tablaName, note.toMap(), where: '$colId=?', whereArgs: [note.id]);
    return result;
  }

  Future<int> delete(Note note) async {
    Database db = await this.database;
    var result = await db.delete(tablaName, where: '$colId=?', whereArgs: [note.id]);
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> obj = await db.rawQuery('select count(id) from $tablaName');
    int result = Sqflite.firstIntValue(obj);
    return result;
  }
}
