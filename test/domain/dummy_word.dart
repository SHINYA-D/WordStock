import 'package:wordstock/model/word/word.dart';

class DummyWord {
  static List<Word> initialValue = [
    Word(
      id: 'id',
      frontName: 'frontName',
      backName: 'backName',
      tableName: 'tableName',
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
}
