import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/pages/pages.dart';
import 'package:qr_reader/providers/db_provider.dart';
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
          IconButton(onPressed: () {}, icon: const Icon(Icons.delete_forever))
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

    //TODO: Temportal, Leer DB
    //final ScanM = new ScanModel(value: 'https://www.covid19.com');

    // DBProvider.db.getScanById(2).then((s) => print(s.value));

    // DBProvider.db.getScansByType('https').then(print);

    // DBProvider.db.getAllScan().then(print);

    //DBProvider.db.newScan(ScanM);

    // ScanModel smodel =
    //     ScanModel(id: 2, type: 'https', value: 'http://wwww.ah1n1.com');

    // DBProvider.db.updateScan(smodel);
    DBProvider.db.deleteAllScans().then(print);

    switch (currentIndx) {
      case 0:
        return MapHistory();
      case 1:
        return AddressPage();

      default:
        return MapHistory();
    }
  }
}
