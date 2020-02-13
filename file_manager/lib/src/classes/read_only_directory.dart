import 'file.dart';

class ReadOnlyDirectory extends ReadOnlyFile {
  ReadOnlyDirectory(String path, this.children) : super(path);

  final List<FileBase> children;
}
