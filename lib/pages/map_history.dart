import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/db_provider.dart';

import '../providers/scan_list_provider.dart';

class MapHistory extends StatelessWidget {
  const MapHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_, i) => Dismissible(
        //TODO: Investigar por que el UniqueKey del profesor no funciona y por que da error si generamos un key unico nosotros mismos

        key: Key(i.toString()),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (direction) {
          //scans.removeAt(i);
        },
        child: ListTile(
          leading: Icon(Icons.map, color: Theme.of(context).primaryColor),
          title: Text(scans[i].value),
          subtitle: Text(scans[i].id.toString()),
          trailing: const Icon(
            Icons.keyboard_arrow_right,
            color: Colors.grey,
          ),
          onTap: () => print(scans[i].id),
        ),
      ),
    );
  }
}
