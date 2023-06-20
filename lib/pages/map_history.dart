import 'package:flutter/material.dart';

import '../widgets/scan_tiles.dart';

class MapHistory extends StatelessWidget {
  const MapHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScanTiles(type: "geo");
  }
}
