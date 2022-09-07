import 'package:sqflite/sqflite.dart';
import 'package:wordstock/model/folder/folder.dart';
import 'package:wordstock/model/word/word.dart';
import 'package:wordstock/repository/sqlite_repository.dart';

import '../../domain/word/dummy_not_word.dart';
import '../../domain/word/dummy_word.dart';

class DummyWordRepository implements SqliteRepository {
  @override
  // TODO: implement database
  Future<Database?> get database => throw UnimplementedError();

  @override
  Future<List<Folder>> deleteFolder(String? id) {
    // TODO: implement registerWord
    throw UnimplementedError();
  }

  @override
  Future<List<Word>> deleteIdSearch(String? folderNameId) {
    // TODO: implement registerWord
    throw UnimplementedError();
  }

  @override
  Future<List<Word>> deleteWord(String id) =>
      Future.value(DummyNotWord.initialValue);

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
      Future.value(DummyWord.initialValue);

  @override
  Future<List<Word>> getWords() {
    // TODO: implement getWords
    throw UnimplementedError();
  }

  @override
  Future<List<Word>> registerFolder(Folder indata) {
    // TODO: implement registerWord
    throw UnimplementedError();
  }

  @override
  Future<void> registerWord(Word indata) {
    // TODO: implement registerWord
    throw UnimplementedError();
  }

  @override
  Future<void> upFolder(Folder up) {
    // TODO: implement upFolder
    throw UnimplementedError();
  }

  @override
  Future<void> upWord(Word word) {
    // TODO: implement upWord
    throw UnimplementedError();
  }

  @override
  Future<List<Folder>> getFolders() =>
      Future.value(DummyWord.initialFolderValue);
}
