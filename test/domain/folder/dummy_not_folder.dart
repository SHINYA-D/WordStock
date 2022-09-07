import 'package:wordstock/model/folder/folder.dart';
import 'package:wordstock/model/word/word.dart';

class DummyNotFolder {
  static List<Folder> initialValue = [
    Folder(
      id: null,
      name: null,
      tableName: null,
    )
  ];

  static List<Word> initialWordValue = [
    Word(
      id: null,
      frontName: null,
      backName: null,
      tableName: null,
      folderNameId: null,
      yesCount: null,
      noCount: null,
      play: null,
      time: null,
      percent: null,
      average: null,
      passed: null,
    )
  ];
}
