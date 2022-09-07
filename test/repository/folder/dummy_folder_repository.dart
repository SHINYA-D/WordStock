import 'package:sqflite/sqflite.dart';
import 'package:wordstock/model/folder/folder.dart';
import 'package:wordstock/model/word/word.dart';
import 'package:wordstock/repository/sqlite_repository.dart';

import '../../domain/folder/dummy_folder.dart';
import '../../domain/folder/dummy_not_folder.dart';

class DummyRepository implements SqliteRepository {
  @override
  // TODO: implement database
  Future<Database?> get database => throw UnimplementedError();

  @override
  Future<List<Folder>> deleteFolder(String? id) =>
      Future.value(DummyNotFolder.initialValue);

  @override
  Future<List<Word>> deleteIdSearch(String? folderNameId) =>
      Future.value(DummyNotFolder.initialWordValue);

  @override
  Future<List<Word>> deleteWord(String id) =>
      Future.value(DummyNotFolder.initialWordValue);

  @override
  Future<List<Word>> getPointBad(String folderId) {
    // TODO: implement getPointBad
    throw UnimplementedError();
  }

  @override
  Future<List<Word>> getPointGood(String folderId) {
    // TODO: implement getPointGood
    throw UnimplementedError();
  }

  @override
  Future<List<Word>> getPointWords(String folderIdNum) =>
      Future.value(DummyNotFolder.initialWordValue);

  @override
  Future<List<Word>> getWords() {
    // TODO: implement getWords
    throw UnimplementedError();
  }

  @override
  Future<List<Folder>> registerFolder(Folder indata) async =>
      Future.value(DummyFolder.initialValue);

  @override
  Future<void> registerWord(Word indata) {
    // TODO: implement registerWord
    throw UnimplementedError();
  }

  @override
  Future<List<Folder>> upFolder(Folder up) =>
      Future.value(DummyFolder.initialValue);

  @override
  Future<void> upWord(Word word) {
    // TODO: implement upWord
    throw UnimplementedError();
  }

  @override
  Future<List<Folder>> getFolders() => Future.value(DummyFolder.initialValue);
}
