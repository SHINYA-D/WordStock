import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordstock/domain/folder/folder.dart';
import 'package:wordstock/repository/sqlite_repository.dart';

final allFoldersProvider =
    FutureProvider((ref) => ref.read(sqliteRepositoryProvider).getFolders());

final allWordsProvider =
    FutureProvider((ref) => ref.read(sqliteRepositoryProvider).getWords());

final analysisProvider =
    StateNotifierProvider<AnalysisController,List<Folder>>((ref) {
  final sqliteRepo = ref.read(sqliteRepositoryProvider);
  final allFolders = ref.watch(allFoldersProvider);
  final allWords = ref.watch(allWordsProvider);

  //allFolders = allFolders == null ?



  final folders =allFolders.value!.map((folder) {
     final dividedTheWords = allWords.value!.where((word) => word.folderNameId == folder.id).toList();
     final List<int?> averages = dividedTheWords.map((oneAverage) => oneAverage.average).toList();
     final int? averagesTotal = averages.reduce((value, element) => value! + element!);
     final average = (averagesTotal! / averages.length).round();
    print(average); // 平均点を表示
     final totalAverages = averagesTotal ?? 0;
     return folder = folder.copyWith(folderPercent: average);
  }).toList();



  return AnalysisController(sqliteRepo, folders);
});

class AnalysisController extends StateNotifier<List<Folder>> {
  AnalysisController(this.sqliteRepo, this.allFolders) : super(allFolders);

  final SqliteRepository sqliteRepo;
  final List<Folder> allFolders;

}
