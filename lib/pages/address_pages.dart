import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/scan_list_provider.dart';

class AddressPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);

    return ListView.builder(
      itemCount: scanListProvider.scans.length,
      itemBuilder: (BuildContext _, int index) => ListTile(
        leading:
            Icon(Icons.home_outlined, color: Theme.of(context).primaryColor),
        title: Text(scanListProvider.scans[index].value),
        subtitle: Text('${scanListProvider.scans[index].id}'),
        trailing: const Icon(
          Icons.keyboard_arrow_right,
          color: Colors.grey,
        ),
        onTap: () => print(scanListProvider.scans[index].id),
      ),
    );
  }
}
