import 'file.dart';

class ReadOnlyDirectory extends FileBase {
  ReadOnlyDirectory(String path, this.children) : super(path);

  final List<FileBase> children;

  @override
  String toString() {
    final sb = StringBuffer();
    sb.writeln("Directory: ${this.path}");
    for (var item in children) {
      sb.writeln("- ${item.path}");
    }
    return sb.toString();
  }
}
