import 'package:file_chooser/file_chooser.dart';
import 'dart:io' as io;

import '../classes/file.dart';

Future<List<FileBase>> openFile({
  String fileTypesWeb = '*',
  List<String> fileTypesDesktop,
  String initialDirectoryDesktop,
  bool silentErrors = false,
  bool allowSelectDirectories = false,
  bool allowSelectMultiple = false,
}) async {
  if (io.Platform.isMacOS || io.Platform.isLinux || io.Platform.isWindows) {
    final result = await showOpenPanel(
      initialDirectory: initialDirectoryDesktop,
      canSelectDirectories: allowSelectDirectories,
      allowedFileTypes: fileTypesDesktop,
      allowsMultipleSelection: allowSelectMultiple,
    );

    if (!result.canceled) {
      if (allowSelectDirectories) {
        final _paths = result?.paths ?? [];
        List<FileBase> _files = [];
        for (var path in _paths) {
          final dir = io.Directory(path);
          _files.addAll(_readDir(dir));
        }
        return _files;
      } else {
        final _paths = result?.paths ?? [];
        return _paths.map((p) {
          final item = io.File(p);
          return ReadOnlyFile(
            item.path,
            readString: () => item.readAsString(),
            readBytes: () => item.readAsBytes(),
          );
        }).toList();
      }
    }
  }
  return null;
}

List<FileBase> _readDir(io.Directory dir) {
  List<FileBase> _files = [];
  if (dir.existsSync()) {
    for (var item in dir.listSync(recursive: true)) {
      if (item is io.File) {
        final _file = ReadOnlyFile(
          item.path,
          readString: () => item.readAsString(),
          readBytes: () => item.readAsBytes(),
        );
        _files.add(_file);
      }
      if (item is io.Directory) {
        final _dir = ReadOnlyDirectory(item.path, _readDir(item));
        _files.add(_dir);
      }
    }
  }
  return _files;
}
