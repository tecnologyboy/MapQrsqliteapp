import 'package:flutter/material.dart';

//

class HomeWidget extends StatelessWidget {
  final items = List<int>.generate(10, (i) => i + 1);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((i) {
        return Dismissible(
          key: ValueKey(i),
          child: ListTile(
            title: Text("Item $i"),
          ),
        );
      }).toList(),
    );
  }
}
