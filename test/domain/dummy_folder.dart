import 'package:wordstock/model/folder/folder.dart';

class DummyFolder {
  static List<Folder> initialValue = [
    Folder(
      id: "testFolderId",
      name: "testFolderName",
      tableName: "testFolderTableName",
    )
  ];
}
