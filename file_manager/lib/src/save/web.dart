import 'package:universal_html/html.dart' as html;

Future<bool> saveFile(
  String fileName, {
  String initialDirectoryDesktop,
  String stringData,
  List<int> binaryData,
  bool silentErrors = false,
}) async {
  assert(stringData != null || binaryData != null);
  Uri dataUrl;
  try {
    if (stringData != null) {
      dataUrl = Uri.dataFromString(stringData);
    }
    if (binaryData != null) {
      dataUrl = Uri.dataFromBytes(binaryData);
    }
  } catch (e) {
    if (!silentErrors) {
      throw Exception("Error Creating File Data: $e");
    }
    return false;
  }
  final _element = html.AnchorElement()
    ..href = dataUrl.toString()
    ..setAttribute("download", fileName);
  _element.click();
  return true;
}
