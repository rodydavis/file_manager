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
  String _data = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Download Example"),
        actions: <Widget>[
          IconButton(
            tooltip: "Download File",
            icon: Icon(Icons.cloud_download),
            onPressed: () {
              manager.saveData(
                'my_file.txt',
                stringData: _data,
                // binaryData: utf8.encode(_data),
              );
            },
          ),
        ],
      ),
      body: DropZone(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  hintText: 'Enter Text Here',
                  border: InputBorder.none,
                ),
                maxLines: null,
                onChanged: (val) => _data = val,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
