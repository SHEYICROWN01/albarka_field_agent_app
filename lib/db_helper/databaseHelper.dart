// ignore: file_names
import 'dart:io';
import 'package:albarka_agent_app/app_export.dart';

import 'package:albarka_agent_app/db_helper/getSavingsModel.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static const login = 'login';
  static const savings = 'savings';
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  factory DatabaseHelper() {
    return instance;
  }
  static Database? _database;

  Future<Database> get database async => _database = await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'albarka01.db');
    return await openDatabase(path, version: 3, onCreate: ((db, version) async {
      await db.execute(tableSavings);
    }));
  }

  static const tableSavings = 'CREATE TABLE $savings('
      'id INTEGER PRIMARY KEY AUTOINCREMENT,'
      'memberID TEXT,'
      'memberName TEXT,'
      'amount TEXT,'
      'agentID TEXT,'
      'branch TEXT,'
      'contributionType TEXT,'
      'transactionType TEXT,'
      'dateTime TEXT,'
      'dateNow TEXT,'
      'agentUsername TEXT'
      ')';

  Future<String> addSavings(MySavingsModel savingsModel) async {
    Database db = await instance.database;
    return await db.insert('savings', savingsModel.toMap()).then((value) {
      if (value > 0) {
        return 'Successful';
      } else {
        return 'Error';
      }
    });
  }

  Future<List<getSavingsModel>> getAllSavings(String agentUsername) async {
    Database db = await instance.database;
    var allSavings = await db.query('savings',
        orderBy: 'id', where: 'agentUsername = ?', whereArgs: [agentUsername]);
    List<getSavingsModel> savingsList = allSavings.isNotEmpty
        ? allSavings.map((e) => getSavingsModel.fromMap(e)).toList()
        : [];
    return savingsList;
  }

  Future<void> deleteRecordByID(
    String tableName,
    int id,
  ) async {
    final db = await database;
    await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
