import 'package:file/memory.dart';
import 'package:test/test.dart';

var fs = MemoryFileSystem();

void main() {
  setUp(() async {
    await fs.file('baseTest.txt').writeAsString('Hello world!');
    await fs.file('outputTest.txt').writeAsString('This is a test string');
    await fs.file('binaryTest.txt').writeAsBytes([0, 2, 3, 7, 3, 2, 4, 32, 3]);
  });

  test('base file exists', () {
    final _file = fs.file('baseTest.txt');
    expect(
      _file.existsSync(),
      equals(true),
    );
  });

  test('check contents of file', () {
    final _file = fs.file('outputTest.txt');
    final _content = _file.readAsStringSync();
    expect(
      _content,
      equals('This is a test string'),
    );
  });
}
