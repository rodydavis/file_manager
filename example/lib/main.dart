import 'package:flutter/material.dart';
import 'package:file_manager/file_manager.dart' as manager;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Downloader Example',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: FileDownloadExample(),
    );
  }
}

class FileDownloadExample extends StatefulWidget {
  @override
  _FileDownloadExampleState createState() => _FileDownloadExampleState();
}

class _FileDownloadExampleState extends State<FileDownloadExample> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Download Example"),
        actions: <Widget>[
          IconButton(
            tooltip: "Upload File",
            icon: Icon(Icons.file_upload),
            onPressed: () {
              manager.openFile().then((files) async {
                if (files != null) {
                  String _contents;
                  final _file = files.first;
                  if (_file is manager.ReadOnlyFile) {
                    _contents = await _file.readString();
                  }
                  if (mounted)
                    setState(() {
                      _controller.text = _contents;
                    });
                }
              });
            },
          ),
          IconButton(
            tooltip: "Upload Files",
            icon: Icon(Icons.content_copy),
            onPressed: () {
              manager.openFile(allowSelectMultiple: true).then((files) {
                if (files != null) {
                  if (mounted)
                    setState(() {
                      _controller.text = files.map((e) => e.path).join("\n");
                    });
                }
              });
            },
          ),
          IconButton(
            tooltip: "Upload Folder",
            icon: Icon(Icons.folder),
            onPressed: () {
              manager.openFile(allowSelectDirectories: true).then((files) {
                if (files != null) {
                  if (mounted)
                    setState(() {
                      _controller.text = files.map((e) => e.path).join("\n");
                    });
                }
              });
            },
          ),
          IconButton(
            tooltip: "Download File",
            icon: Icon(Icons.cloud_download),
            onPressed: () {
              manager.saveFile(
                'my_file.txt',
                stringData: _controller.text,
                // binaryData: utf8.encode(_data),
              );
            },
          ),
        ],
      ),
      body: manager.DropZone(
        onFilesDropped: (files) {
          for (var file in files) {
            print("File: ${file.path}");
          }
        },
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                // style: TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  hintText: 'Enter Text Here',
                  border: InputBorder.none,
                ),
                maxLines: null,
                controller: _controller,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
