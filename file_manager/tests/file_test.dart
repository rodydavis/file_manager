import 'package:file/memory.dart';
import 'package:file/file.dart';
import 'package:test/test.dart';

var fs = MemoryFileSystem();

void main() {
  setUp(() async {
    final File outputFile = fs.file('base.txt');
    await outputFile.writeAsString('Hello world!');
  });

  test('base file exists', () {
    final _file = fs.file('base.txt');
    expect(
      _file.existsSync(),
      equals(true),
    );
  });
}
