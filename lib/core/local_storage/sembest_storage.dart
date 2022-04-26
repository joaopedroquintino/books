import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';

class SembastStorage {
  SembastStorage._();

  static SembastStorage? _singleton;

  static SembastStorage get instance => _singleton ??= SembastStorage._();

  Completer<Database>? _dbOpenCompleter;

  Future<Database> get database async {
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
      await _openDatabase();
    }

    return _dbOpenCompleter!.future;
  }

  Future<void> _openDatabase() async {
    if (kIsWeb) {
      final Database database = await databaseFactoryWeb.openDatabase('books');
      _dbOpenCompleter!.complete(database);
    } else {
      final Directory documentDirectory =
          await getApplicationDocumentsDirectory();
      final String dbPath = join(documentDirectory.path, 'sembest_db');
      final Database database = await databaseFactoryIo.openDatabase(dbPath);
      _dbOpenCompleter!.complete(database);
    }
  }
}
