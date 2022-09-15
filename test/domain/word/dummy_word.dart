import 'package:wordstock/domain/folder/folder.dart';
import 'package:wordstock/domain/word/word.dart';

class DummyWord {
  static List<Word> initialValue = [
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
      passed: 'FLAT',
    )
  ];

  static List<Word> wordEmptyValue = [];

  static List<Folder> initialFolderValue = [
    Folder(
      id: "wordTestFolderId",
      name: "wordTestFolderName",
    )
  ];
}
