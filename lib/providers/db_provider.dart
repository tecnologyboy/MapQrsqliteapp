import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
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

  Future<ScanModel> getScanById(int id) async {
    final db = await database;
    final res = await db!.query('Scans', where: 'id=?', whereArgs: [id]);

    //TODO: Buscar la forma de que funcione con if ternario

    // return res.isNotEmpty
    //         ? ScanModel.fromJson(res.first)
    //         : [];

    final rtn;
    if (res.isNotEmpty) {
      rtn = ScanModel.fromJson(res.first);
    } else {
      rtn = [];
    }

    return rtn;
  }

  Future<List<ScanModel>> getAllScan() async {
    final db = await database;
    final res = await db!.query('Scans');

    //TODO: Buscar la forma de que funcione con if ternario

    // return res.isNotEmpty
    //         ? ScanModel.fromJson(res.first)
    //         : [];

    final rtn;
    if (res.isNotEmpty) {
      rtn = res.map((e) => ScanModel.fromJson(e)).toList();
    } else {
      rtn = [];
    }

    return rtn;
  }

  Future<List<dynamic>> getScansByType(String type) async {
    final db = await database;
    final res = await db!.rawQuery('''
        SELECT * FROM Scans WHERE type = '$type'

    ''');

    //TODO: Buscar la forma de que funcione con if ternario

    // return res.isNotEmpty
    //         ? ScanModel.fromJson(res.first)
    //         : [];

    final rtn;
    if (res.isNotEmpty) {
      rtn = res.map((e) => ScanModel.fromJson(e)).toList();
    } else {
      rtn = [];
    }

    return rtn;
  }

  Future<int> updateScan(ScanModel updateRecord) async {
    final db = await database;

    final res = await db!.update('Scans', updateRecord.toJson(),
        where: 'id =?', whereArgs: [updateRecord.id]);

    return res;
  }

  Future<int> deleteScans(int id) async {
    final db = await database;
    final res = await db!.delete('scans', where: 'id=?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllScans() async {
    final db = await database;
    final res = await db!.rawDelete('''
      DELETE FROM scans
    ''');
    return res;
  }
}
