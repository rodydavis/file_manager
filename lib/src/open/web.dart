import 'package:universal_html/html.dart' as html;

import '../classes/file.dart';

Future<List<FileBase>> openFile({
  String fileTypesWeb = '*',
  List<String> fileTypesDesktop,
  String initialDirectoryDesktop,
  bool silentErrors = false,
  bool allowSelectDirectories = false,
  bool allowSelectMultiple = false,
}) async {
  final _upload = html.FileUploadInputElement();
  _upload.accept = fileTypesWeb;
  if (allowSelectMultiple) {
    _upload.multiple = true;
  }
  if (allowSelectDirectories) {
    _upload.setAttribute('webkitdirectory', '');
    _upload.setAttribute('mozdirectory', '');
  }
  _upload.click();
  final _file = await _upload.onChange.first;
  if (_file != null) {
    List<html.File> files = (_file.target as dynamic).files;
    return files.map((f) {
      return ReadOnlyFile(
        allowSelectDirectories ? f.relativePath : f.name,
        readString: () async {
          final reader = new html.FileReader();
          reader.readAsText(f);
          await reader.onLoadEnd.first;
          return reader.result;
        },
        readBytes: () async {
          final reader = new html.FileReader();
          reader.readAsArrayBuffer(f);
          await reader.onLoadEnd.first;
          return reader.result as List<int>;
        },
      );
    }).toList();
  }
  return [];
}
