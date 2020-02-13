import 'dart:typed_data';

import 'base.dart';

class ReadOnlyFile extends FileBase {
  ReadOnlyFile(String path) : super(path);

  Future<List<Uint8List>> readAsBytes() async {}

  Future<String> readAsString() async {}
}
