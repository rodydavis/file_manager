library drop_zone;

export 'drop/unsupported.dart'
    if (dart.library.html) 'drop/web.dart'
    if (dart.library.io) 'drop/io.dart';
