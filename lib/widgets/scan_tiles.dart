import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/scan_list_provider.dart';

class ScanTiles extends StatelessWidget {
  const ScanTiles({super.key, required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);

    return ListView.builder(
      itemCount: scanListProvider.scans.length,
      itemBuilder: (_, i) => Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) {},
        child: ListTile(
          leading: Icon(
              type == "http" ? Icons.home_outlined : Icons.map_outlined,
              color: Theme.of(context).primaryColor),
          title: Text(scanListProvider.scans[i].value),
          subtitle: Text('${scanListProvider.scans[i].id}'),
          trailing: const Icon(
            Icons.keyboard_arrow_right,
            color: Colors.grey,
          ),
          onTap: () => print(scanListProvider.scans[i].id),
        ),
      ),
    );
  }
}
