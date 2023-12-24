import 'package:wordstock/domain/folder/folder.dart';
import 'package:wordstock/domain/word/word.dart';

class DummyFolder {
  static List<Folder> initialValue = [
    Folder(
      id: "testFolderId",
      name: "testFolderName",
    )
  ];

  static List<Folder> folderEmptyValue = [];

  static List<Word> initialWordValue = [
    Word(
      id: 'id',
      frontName: 'frontName',
      backName: 'backName',
      folderNameId: 'folderNameId',
      yesCount: 1,
      noCount: 1,
      play: 1,
      time: 1111,
      percent: 20,
      average: 30,
      passed: 'OK',
    )
  ];

  static List<Word> initialWordBad = [
    Word(
      id: 'id',
      frontName: 'frontName',
      backName: 'backName',
      folderNameId: 'folderNameIdBad',
      yesCount: 1,
      noCount: 1,
      play: 1,
      time: 1111,
      percent: 20,
      average: 30,
      passed: 'NG',
    )
  ];
}
