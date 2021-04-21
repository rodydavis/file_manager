import 'package:universal_html/html.dart' as html;
import 'dart:io' as io;

import 'package:file_chooser/file_chooser.dart';
import 'package:flutter/foundation.dart';

Future<bool> saveFile(
  String fileName, {
  String initialDirectoryDesktop,
  String stringData,
  List<int> binaryData,
  bool silentErrors = false,
}) async {
  assert(stringData != null || binaryData != null);
  if (io.Platform.isMacOS || io.Platform.isLinux || io.Platform.isWindows) {
    final result = await showSavePanel(
      suggestedFileName: fileName,
      initialDirectory: initialDirectoryDesktop,
    );

    if (!result.canceled) {
      final _path = result?.paths?.first ?? '';
      final _file = io.File(_path);
      if (!_file.existsSync()) {
        try {
          await _file.create(recursive: true);
        } catch (e) {
          if (!silentErrors) {
            throw Exception("Error Creating File: $e");
          }
          return false;
        }
      }
      if (binaryData != null) {
        await _file.writeAsBytes(binaryData);
      }
      if (stringData != null) {
        await _file.writeAsString(stringData);
      }
      return true;
    }
  }
  return false;
}
