import 'file.dart';

class ReadOnlyDirectory extends FileBase {
  ReadOnlyDirectory(String path, this.children) : super(path);

  final List<FileBase> children;
}
