import 'package:wordstock/model/folder/folder.dart';
import 'package:wordstock/model/word/word.dart';

class DummyPlay {
  static List<Word> initialValue = [
    Word(
      id: 'id',
      frontName: 'frontPlayName',
      backName: 'backPlayName',
      tableName: 'tablePlayName',
      folderNameId: 'folderPlayNameId',
      yesCount: 0,
      noCount: 0,
      play: 0,
      time: 0000,
      percent: 0,
      average: 0,
      passed: 'FLAT',
    )
  ];

  static List<Folder> initialFolderValue = [
    Folder(
      id: "wordTestFolderId",
      name: "wordTestFolderName",
      tableName: "wordTestFolderTableName",
    )
  ];
}
