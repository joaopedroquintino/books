import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class SembestStorage {
  SembestStorage._();

  static SembestStorage? _singleton;

  static SembestStorage get instance => _singleton ??= SembestStorage._();

  Completer<Database>? _dbOpenCompleter;

  Future<Database> get database async {
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
      await _openDatabase();
    }

    return _dbOpenCompleter!.future;
  }

  Future<void> _openDatabase() async {
    final Directory documentDirectory =
        await getApplicationDocumentsDirectory();
    final String dbPath = join(documentDirectory.path, 'sembest_db');

    final Database database = await databaseFactoryIo.openDatabase(dbPath);
    _dbOpenCompleter!.complete(database);
  }
}
