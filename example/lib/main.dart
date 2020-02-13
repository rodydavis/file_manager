import 'package:drop_zone/drop_zone.dart';
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
            icon: Icon(Icons.cloud_upload),
            onPressed: () {
              manager
                  .openFile(
                allowSelectDirectories: true,
              )
                  .then((files) {
                if (files != null) {
                  for (var file in files) {
                    print('Path: ${file.path}');
                  }
                  if (mounted)
                    setState(() {
                      _controller.text = files.first.path;
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
      body: DropZone(
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
