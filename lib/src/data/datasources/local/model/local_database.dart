import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'fact_model.dart';

class LocalDatabase {
  static final LocalDatabase getInstance = LocalDatabase._init();

  LocalDatabase._init();

  factory LocalDatabase() {
    return getInstance;
  }

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDB("cats.db");
      return _database!;
    }
  }

  Future<Database> _initDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";
    const intType = "INTEGER DEFAULT 0";

    await db.execute('''
    CREATE TABLE ${FactModelFields.catFactTable} (
    ${FactModelFields.id} $idType,
    ${FactModelFields.name} $textType,
    ${FactModelFields.date} $textType,
    ${FactModelFields.imagePath} $textType
    )
    ''');

    debugPrint("-------DB----------CREATED---------");
  }

  static Future<FactModelSql> insertFact(
      FactModelSql contactsModelSql) async {
    final db = await getInstance.database;
    final int id = await db.insert(
        FactModelFields.catFactTable, contactsModelSql.toJson());
    return contactsModelSql.copyWith(id: id);
  }

  static Future<List<FactModelSql>> getAllFact() async {
    List<FactModelSql> allToDos = [];
    final db = await getInstance.database;
    allToDos = (await db.query(FactModelFields.catFactTable))
        .map((e) => FactModelSql.fromJson(e))
        .toList();

    return allToDos;
  }

  static updateFactName({required int id, required String name}) async {
    final db = await getInstance.database;
    db.update(
      FactModelFields.catFactTable,
      {FactModelFields.name: name},
      where: "${FactModelFields.id} = ?",
      whereArgs: [id],
    );
  }

  static updateFact({required FactModelSql contactsModelSql}) async {
    final db = await getInstance.database;
    db.update(
      FactModelFields.catFactTable,
      contactsModelSql.toJson(),
      where: "${FactModelFields.id} = ?",
      whereArgs: [contactsModelSql.id],
    );
  }

  static Future<int> deleteFact(int id) async {
    final db = await getInstance.database;
    int count = await db.delete(
      FactModelFields.catFactTable,
      where: "${FactModelFields.id} = ?",
      whereArgs: [id],
    );
    return count;
  }
}
