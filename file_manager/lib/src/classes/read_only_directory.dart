import 'file.dart';

class ReadOnlyDirectory extends ReadOnlyFile {
  ReadOnlyDirectory(String path) : super(path);

  Future<List<ReadOnlyFile>> listFiles() async {}
}
