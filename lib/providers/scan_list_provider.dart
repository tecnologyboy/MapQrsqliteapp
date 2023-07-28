import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];

  String selectedType = 'http';

  Future<ScanModel> newScans(String value) async {
    final newScans = ScanModel(value: value);

    final id = await DBProvider.db.newScan(newScans);

    newScans.id = id;

    if (selectedType == newScans.type) {
      scans.add(newScans);
      notifyListeners();
    }

    return newScans;
  }

  uploadAllScans() async {
    final allScans = await DBProvider.db.getAllScan();
    scans = [...allScans];
    notifyListeners();
  }

  uploadScansByType(String type) async {
    final typeScans = await DBProvider.db.getScansByType(type);
    scans = [...typeScans];
    selectedType = type;
    notifyListeners();
  }

  deleteAllScans() async {
    await DBProvider.db.deleteAllScans();
    scans = [];
    notifyListeners();
  }

  deleteScansById(int id) async {
    await DBProvider.db.deleteScansById(id);
    uploadScansByType(selectedType);
  }
}
