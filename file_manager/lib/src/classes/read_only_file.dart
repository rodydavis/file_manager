import 'package:flutter/material.dart';

import 'base.dart';

class ReadOnlyFile extends FileBase {
  ReadOnlyFile(
    String path, {
    @required this.readBytes,
    @required this.readString,
  }) : super(path);

  final Future<String> Function() readString;
  final Future<List<int>> Function() readBytes;

  @override
  String toString() {
    return path;
  }
}
