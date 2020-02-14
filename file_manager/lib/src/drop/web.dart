import 'dart:async';
import 'dart:html';

import 'package:flutter/material.dart';

import '../../file_manager.dart';

enum _DragState {
  dragging,
  notDragging,
}

class DropZone extends StatefulWidget {
  final Widget child;
  final ValueChanged<List<FileBase>> onFilesDropped;

  const DropZone({
    Key key,
    this.child,
    this.onFilesDropped,
  }) : super(key: key);

  @override
  _DropZoneState createState() => _DropZoneState();
}

class _DropZoneState extends State<DropZone> {
  StreamSubscription<MouseEvent> _onDragOverSubscription;
  StreamSubscription<MouseEvent> _onDropSubscription;

  final _pointStreamController =
      new StreamController<Point<double>>.broadcast();
  final _dragStateStreamController =
      new StreamController<_DragState>.broadcast();

  @override
  void dispose() {
    _onDropSubscription.cancel();
    _onDragOverSubscription.cancel();
    _pointStreamController.close();
    _dragStateStreamController.close();
    super.dispose();
  }

  void _onDrop(MouseEvent value) {
    value.stopPropagation();
    value.preventDefault();
    _pointStreamController.sink.add(null);
    _addFiles(value.dataTransfer.items);
  }

  void _addFiles(DataTransferItemList items) async {
    if (widget?.onFilesDropped != null) {
      //  items[0].getAsFile()
      print("ITEMS ${items.length}");
      final List<FileBase> _files = [];
      for (var i = 0; i < items.length; i++) {
        final DataTransferItem item = items[i];
        // ReadOnlyFile _file = await _readOnlyFile(item.getAsFile());
        // _files.add(_file);
        
        final Entry entry = item.getAsEntry();
        
        if (item.type == "") {
          final _children = await _readDir(entry as DirectoryEntry);
          _files.add(ReadOnlyDirectory(entry.fullPath, _children));
        } else {
          FileBase _file = await _getFile(entry as FileEntry);
          _files.add(_file);
        }
      }
      widget.onFilesDropped(_files);
      _files.clear();
    }
  }

  Future<FileBase> _getFile(FileEntry file) async {
    final f = await file.file();
    ReadOnlyFile _file = await _readOnlyFile(f);
    return _file;
  }

  Future<FileBase> _readOnlyFile(File f) async {
    final _file = ReadOnlyFile(
      f.name,
      readString: () async {
        final reader = new FileReader();
        reader.readAsText(f);
        await reader.onLoadEnd.first;
        return reader.result;
      },
      readBytes: () async {
        final reader = new FileReader();
        reader.readAsArrayBuffer(f);
        await reader.onLoadEnd.first;
        return reader.result as List<int>;
      },
    );
    return _file;
  }

  Future<List<FileBase>> _readDir(DirectoryEntry directory) async {
    final List<FileBase> _files = [];
    final reader = directory.createReader();
    final _children = await reader.readEntries();
    if (_children != null) {
      for (var item in _children) {
        if (item.isFile) {
          final _file = await _getFile(item);
          if (_file != null) {
            _files.add(_file);
          }
        }
        if (item.isDirectory) {
          final _children = await _readDir(item as DirectoryEntry);
          if (_children != null) {
            _files.add(ReadOnlyDirectory(item.fullPath, _children));
          }
        }
      }
    }
    return _files;
  }

  void _onDragOver(MouseEvent value) {
    value.stopPropagation();
    value.preventDefault();
    this
        ._pointStreamController
        .sink
        .add(Point<double>(value.layer.x.toDouble(), value.layer.y.toDouble()));
    this._dragStateStreamController.sink.add(_DragState.dragging);
  }

  @override
  void initState() {
    super.initState();
    this._onDropSubscription = document.body.onDrop.listen(_onDrop);
    this._onDragOverSubscription = document.body.onDragOver.listen(_onDragOver);
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: widget?.child);
  }
}
