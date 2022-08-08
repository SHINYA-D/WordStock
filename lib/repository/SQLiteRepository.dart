// ignore_for_file: file_names, depend_on_referenced_packages, slash_for_doc_comments, avoid_print
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wordstock/model/folder_model/folder_model.dart';
import 'package:wordstock/model/word_model/word_model.dart';

final sqliteRepositoryProvider = Provider((ref) => SQLiteRepository());

class SQLiteRepository {

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'WordStock.db');
    return await openDatabase(
        path,
        version: 1,
        onCreate: _onCreate
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE folders (id TEXT PRIMARY KEY, name TEXT, tableName TEXT)''');
    await db.execute('''
      CREATE TABLE words(
                wId TEXT PRIMARY KEY,
                wFrontName TEXT,
                wBackName TEXT,
                wTableName TEXT,
                wFolderNameId TEXT,
                wYes INTEGER,
                wNo INTEGER,
                wPlay INTEGER,
                wTime INTEGER,
                wPercent INTEGER,
                wAverage INTEGER,
                wOk TEXT)''');
  }
/*******************************************************************************
【取得】
*******************************************************************************/
  //Folder全件取得
  Future<List<folder_model>> getFolders() async {
    Database? db = await database;
    final List<Map<String, dynamic>> maps =  await db!.query('folders');
    return List.generate(maps.length, (i) {
      return folder_model(
        id: maps[i]['id'],
        name: maps[i]['name'],
        tableName: maps[i]['tableName'],
      );
    });
  }

  //Word全件取得
  Future<List<word_model>> getWords() async {
    Database? db = await database; //DBにアクセスする
    final List<Map<String, dynamic>> maps =  await db!.query('words');
    return List.generate(maps.length, (i) {
      return word_model(
        wId: maps[i]['wId'],
        wFrontName: maps[i]['wFrontName'],
        wBackName: maps[i]['wBackName'],
        wTableName: maps[i]['wTableName'],
        wFolderNameId: maps[i]['wFolderNameId'],
        wYes: maps[i]['wYes'],
        wNo: maps[i]['wNo'],
        wPlay: maps[i]['wPlay'],
        wTime: maps[i]['wTime'],
        wPercent: maps[i]['wPercent'],
        wAverage: maps[i]['wAverage'],
        wOk: maps[i]['wOk'],
      );
    });
  }

  //ID検索取得
  Future<List<word_model>> getPointWord(String forderIdNum) async {
    Database? db = await database; //DBにアクセスする
    final List<Map<String, dynamic>> maps =
    await db!.query('words', where: 'wFolderNameId = ?', whereArgs: [forderIdNum]);
    return List.generate(maps.length, (i) {
      return word_model(
        wId: maps[i]['wId'],
        wFrontName: maps[i]['wFrontName'],
        wBackName: maps[i]['wBackName'],
        wTableName: maps[i]['wTableName'],
        wFolderNameId: maps[i]['wFolderNameId'],
        wYes: maps[i]['wYes'],
        wNo: maps[i]['wNo'],
        wPlay: maps[i]['wPlay'],
        wTime: maps[i]['wTime'],
        wPercent: maps[i]['wPercent'],
        wAverage: maps[i]['wAverage'],
        wOk: maps[i]['wOk'],
      );
    });
  }

  //'対象フォルダ'かつ'NG'の場合を取得
  Future<List<word_model>> getPointNg(String folderIdNum,String ng) async {
    Database? db = await database; //DBにアクセスする
    final List<Map<String, dynamic>> maps =
    await db!.query('words', where: 'wFolderNameId = ? AND wOk = ?',
                                                   whereArgs: [folderIdNum,ng]);
    return List.generate(maps.length, (i) {
      return word_model(
        wId: maps[i]['wId'],
        wFrontName: maps[i]['wFrontName'],
        wBackName: maps[i]['wBackName'],
        wTableName: maps[i]['wTableName'],
        wFolderNameId: maps[i]['wFolderNameId'],
        wYes: maps[i]['wYes'],
        wNo: maps[i]['wNo'],
        wPlay: maps[i]['wPlay'],
        wTime: maps[i]['wTime'],
        wPercent: maps[i]['wPercent'],
        wAverage: maps[i]['wAverage'],
        wOk: maps[i]['wOk'],
      );
    });
  }


/******************************************************************************
【登録】
*******************************************************************************/
  //Folder登録
  Future<void> registerFolder(folder_model indata) async {
    Database? db = await database;
    await db!.insert('folders',indata.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,);
  }

  //Word登録
  Future<void> registerWord(word_model indata) async {
    Database? db = await database;
    await db!.insert('words',indata.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,);
  }
/******************************************************************************
【削除】
*******************************************************************************/
  //Folder削除
  Future<void> deleteFolder(String id) async {
    Database? db = await database;
    await db!.delete('folders', where: 'id = ?', whereArgs: [id]);
  }

  //対象wFolderNameId削除
  Future<void> deleteFolderWord(String wFolderNameId) async {
    Database? db = await database;
    await db!.delete('words', where: 'wFolderNameId = ?',
          whereArgs: [wFolderNameId]);
  }

  //Word削除
  Future<void> deleteWord(String wId) async {
    Database? db = await database;
    await db!.delete('words', where: 'wId = ?', whereArgs: [wId]);
  }
/******************************************************************************
【編集】
*******************************************************************************/
  //Folder編集
  Future<void> upFolder(folder_model up) async {
    Database? db = await database;
    await db!.update('folders', up.toJson(),
        where: 'id = ?', whereArgs: [up.id]);
  }

  //Word編集
  Future<void> upWord(word_model up) async {
    Database? db = await database;
    await db!.update('words', up.toJson(),
        where: 'wId = ?', whereArgs: [up.wId]);
  }
}
