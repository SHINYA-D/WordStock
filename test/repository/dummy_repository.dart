import 'package:sqflite/sqflite.dart';
import 'package:wordstock/domain/folder/folder.dart';
import 'package:wordstock/domain/word/word.dart';
import 'package:wordstock/repository/sqlite_repository.dart';

import '../domain/folder/dummy_folder.dart';
import '../domain/word/dummy_word.dart';

class DummyRepository implements SqliteRepository {
  DummyRepository({required this.playResultScreen});
  final bool playResultScreen;
  @override
  // TODO: implement database
  Future<Database?> get database => throw UnimplementedError();

  @override
  Future<List<Folder>> deleteFolder(String? id) =>
      Future.value(DummyFolder.folderEmptyValue);

  @override
  Future<List<Word>> deleteIdSearch(String? folderNameId) =>
      Future.value(DummyFolder.initialWordValue);

  @override
  Future<List<Word>> deleteWord(String id) =>
      Future.value(DummyWord.wordEmptyValue);

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
  Future<List<Word>> getPointWords(String folderIdNum) {
    if(playResultScreen){
        return Future.value(DummyFolder.initialWordBad);
    }else{
      return  Future.value(DummyFolder.initialWordValue);
    }
  }


  @override
  Future<List<Word>> getWords() {
    // TODO: implement getWords
    throw UnimplementedError();
  }

  @override
  Future<List<Folder>> registerFolder(Folder indata) async =>
      Future.value(DummyFolder.initialValue);

  @override
  Future<List<Word>> registerWord(Word indata) =>
      Future.value(DummyWord.initialValue);

  @override
  Future<List<Folder>> upFolder(Folder up) =>
      Future.value(DummyFolder.initialValue);

  @override
  Future<List<Word>> upWord(Word word) => Future.value(DummyWord.initialValue);

  @override
  Future<List<Folder>> getFolders() => Future.value(DummyFolder.initialValue);
}
