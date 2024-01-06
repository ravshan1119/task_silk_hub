import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'contact_model.dart';

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

  static Future<FactModelSql> insertContact(
      FactModelSql contactsModelSql) async {
    final db = await getInstance.database;
    final int id = await db.insert(
        FactModelFields.catFactTable, contactsModelSql.toJson());
    return contactsModelSql.copyWith(id: id);
  }

  static Future<List<FactModelSql>> getAllContacts() async {
    List<FactModelSql> allToDos = [];
    final db = await getInstance.database;
    allToDos = (await db.query(FactModelFields.catFactTable))
        .map((e) => FactModelSql.fromJson(e))
        .toList();

    return allToDos;
  }

  static updateContactName({required int id, required String name}) async {
    final db = await getInstance.database;
    db.update(
      FactModelFields.catFactTable,
      {FactModelFields.name: name},
      where: "${FactModelFields.id} = ?",
      whereArgs: [id],
    );
  }

  static updateContact({required FactModelSql contactsModelSql}) async {
    final db = await getInstance.database;
    db.update(
      FactModelFields.catFactTable,
      contactsModelSql.toJson(),
      where: "${FactModelFields.id} = ?",
      whereArgs: [contactsModelSql.id],
    );
  }

  static Future<int> deleteContact(int id) async {
    final db = await getInstance.database;
    int count = await db.delete(
      FactModelFields.catFactTable,
      where: "${FactModelFields.id} = ?",
      whereArgs: [id],
    );
    return count;
  }

  static Future<List<FactModelSql>> getContactsByLimit(int limit) async {
    List<FactModelSql> allToDos = [];
    final db = await getInstance.database;
    allToDos = (await db.query(FactModelFields.catFactTable,
            limit: limit, orderBy: "${FactModelFields.name} ASC"))
        .map((e) => FactModelSql.fromJson(e))
        .toList();

    return allToDos;
  }

  static Future<FactModelSql?> getSingleContact(int id) async {
    List<FactModelSql> contacts = [];
    final db = await getInstance.database;
    contacts = (await db.query(
      FactModelFields.catFactTable,
      where: "${FactModelFields.id} = ?",
      whereArgs: [id],
    ))
        .map((e) => FactModelSql.fromJson(e))
        .toList();

    if (contacts.isNotEmpty) {
      return contacts.first;
    }
  }

  static Future<List<FactModelSql>> getContactsByAlphabet(
      String order) async {
    List<FactModelSql> allToDos = [];
    final db = await getInstance.database;
    allToDos = (await db.query(FactModelFields.catFactTable,
            orderBy: "${FactModelFields.name} $order"))
        .map((e) => FactModelSql.fromJson(e))
        .toList();
    return allToDos;
  }

  static Future<List<FactModelSql>> getContactsByQuery(String query) async {
    List<FactModelSql> allToDos = [];
    final db = await getInstance.database;
    allToDos = (await db.query(
      FactModelFields.catFactTable,
      where: "${FactModelFields.name} LIKE ?",
      whereArgs: [query],
    ))
        .map((e) => FactModelSql.fromJson(e))
        .toList();
    return allToDos;
  }
}
