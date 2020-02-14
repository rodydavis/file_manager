import 'package:flutter/material.dart';

import '../../file_manager.dart';


class DropZone extends StatefulWidget {
  final Widget child;
  final ValueChanged<List<FileBase>> onFilesDropped;

  const DropZone({
    Key key,
    this.child,
    this.onFilesDropped,
  }) : super(key: key);

  @override
  _DropZoneState createState() => _DropZoneState();
}

class _DropZoneState extends State<DropZone> {
  @override
  Widget build(BuildContext context) {
    return Container(child: widget.child);
  }
}
