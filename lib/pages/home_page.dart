import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/pages/dismissible_page.dart';
import 'package:qr_reader/pages/pages.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Historial'),
        actions: [
          IconButton(
              icon: const Icon(Icons.delete_forever),
              onPressed: () {
                Provider.of<ScanListProvider>(context, listen: false)
                    .deleteAllScans();
              })
        ],
      ),
      body: const _HomePageBody(),
      bottomNavigationBar: const CustomNavigationBar(),
      floatingActionButton: const ScanBottom(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    //Optener selectedMenuOpt

    final UiProvider uiProvider = Provider.of<UiProvider>(context);

    final currentIndx = uiProvider.selectedMenuOpt;

    //Usar el ScanListProvider
    final scanListProvider = Provider.of<ScanListProvider>(context);

    switch (currentIndx) {
      case 0:
        scanListProvider.uploadScansByType('geo');
        return MapHistory();
      case 1:
        scanListProvider.uploadScansByType('https');
        return AddressPage();

      default:
        return MapHistory();
    }
  }
}
