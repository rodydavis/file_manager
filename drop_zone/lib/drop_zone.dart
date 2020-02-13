library drop_zone;

import 'package:flutter/material.dart';

class DropZone extends StatelessWidget {
  final Widget child;

  const DropZone({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(child: child);
  }
}
