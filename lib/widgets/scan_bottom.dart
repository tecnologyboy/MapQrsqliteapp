import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';

class ScanBottom extends StatelessWidget {
  const ScanBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: const Icon(Icons.filter_center_focus),
      onPressed: () async {
        // String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        //     '#3D8BEF', 'Cancel', false, ScanMode.QR);

        final barcodeScanRes = 'https://confisa.do';

        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);

        //scanListProvider.newScans(barcodeScanRes);
        scanListProvider.newScans('geo:192.167,22.149');
      },
    );
  }
}
