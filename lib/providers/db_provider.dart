import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_reader/models/scan_models.dart';
export 'package:qr_reader/models/scan_models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  Future<Database?> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'ScansDB.db');

    print(path);

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
      CREATE TABLE Scans(
        id INTEGER PRIMARY KEY,
        type TEXT,
        value TEXT)
        ''');
    });
  }

  Future<int> newScanRow(ScanModel newScan) async {
    final id = newScan.id;
    final type = newScan.type;
    final value = newScan.value;

    //verificar la db
    final db = await database;

    final res = await db?.rawInsert('''
        INSERT INTO Scans(id, type, value) 
        VALUES ($id, '$type', '$value')
    ''');

    return res!;
  }

  Future<int> newScan(ScanModel newScan) async {
    final db = await database;

    final res = await db?.insert('scans', newScan.toJson());

    return res!;
  }
}
