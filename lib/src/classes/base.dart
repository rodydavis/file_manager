abstract class FileBase {
  final String path;
  FileBase(this.path);
  bool get isFile => filename.contains(".");
  String get filename => path.split(",").last;
  String get name => filename.split(".").first;
  String get type => filename.split('.').last;
}
