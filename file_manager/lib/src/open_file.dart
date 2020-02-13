import 'package:file_chooser/file_chooser.dart';
import 'package:flutter/foundation.dart';
import 'package:universal_html/html.dart' as html;
import 'dart:io' as io;

import 'classes/file.dart';

Future<List<FileBase>> openFile({
  String fileTypesWeb = '*',
  List<String> fileTypesDesktop,
  String initialDirectoryDesktop,
  bool silentErrors = false,
  bool allowSelectDirectories = false,
  bool allowSelectMultiple = false,
}) async {
  if (kIsWeb) {
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
        return ReadOnlyFile(allowSelectDirectories ? f.relativePath : f.name);
      }).toList();
    }
    return [];
  }
  if (io.Platform.isMacOS || io.Platform.isLinux || io.Platform.isWindows) {
    final result = await showOpenPanel(
      initialDirectory: initialDirectoryDesktop,
      canSelectDirectories: allowSelectDirectories,
      allowedFileTypes: fileTypesDesktop,
      allowsMultipleSelection: allowSelectMultiple,
    );

    if (!result.canceled) {
      final _paths = result?.paths ?? [];
      return _paths.map((p) => ReadOnlyFile(p)).toList();
    }
  }
  return null;
}
