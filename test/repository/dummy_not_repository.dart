import 'package:sqflite/sqflite.dart';
import 'package:wordstock/domain/folder/folder.dart';
import 'package:wordstock/domain/word/word.dart';
import 'package:wordstock/repository/sqlite_repository.dart';

import '../domain/dummy_folder.dart';
import '../domain/dummy_word.dart';

class DummyNotRepository implements SqliteRepository {
  @override
  // TODO: implement database
  Future<Database?> get database => throw UnimplementedError();

  @override
  Future<void> deleteFolder(String? id) {
    // TODO: implement deleteFolder
    throw UnimplementedError();
  }

  @override
  Future<void> deleteIdSearch(String? folderNameId) {
    // TODO: implement deleteIdSearch
    throw UnimplementedError();
  }

  @override
  Future<void> deleteWord(String id) {
    // TODO: implement deleteWord
    throw UnimplementedError();
  }

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
      Future.value(DummyWord.wordEmptyValue);

  @override
  Future<List<Word>> getWords() {
    // TODO: implement getWords
    throw UnimplementedError();
  }

  @override
  Future<List<Folder>> registerFolder(Folder indata) =>
      Future.value(DummyFolder.initialValue);

  @override
  Future<void> registerWord(Word indata) {
    // TODO: implement registerWord
    throw UnimplementedError();
  }

  @override
  Future<void> updateFolder(Folder up) {
    // TODO: implement upFolder
    throw UnimplementedError();
  }

  @override
  Future<void> updateWord(Word word) {
    // TODO: implement upWord
    throw UnimplementedError();
  }

  @override
  Future<List<Folder>> getFolders() =>
      Future.value(DummyFolder.folderEmptyValue);
}
