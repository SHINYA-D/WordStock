import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordstock/domain/folder/folder.dart';
import 'package:wordstock/repository/sqlite_repository.dart';

final allFoldersProvider = FutureProvider.autoDispose(
    (ref) => ref.read(sqliteRepositoryProvider).getFolders());

final allWordsProvider = FutureProvider.autoDispose(
    (ref) => ref.read(sqliteRepositoryProvider).getWords());

final analysisProvider = StateNotifierProvider.autoDispose<AnalysisController,
    AsyncValue<List<Folder>?>>((ref) {
  final sqliteRepo = ref.read(sqliteRepositoryProvider);
  final allFolders = ref.watch(allFoldersProvider);
  final allWords = ref.watch(allWordsProvider);
  // フォルダとワードが空の場合に「NULLの場合[]」を設定する処理が必要
  // 2つ以上の要素があり、１つ以上が空の時にエラーになる
  final getAllFolders = allFolders.value ?? [];
  final getAllWords = allWords.value ?? [];
  final folders = getAllFolders.map((folder) {
    final matchingWordsByFolderId =
        getAllWords.where((word) => word.folderNameId == folder.id).toList();
    if (matchingWordsByFolderId.isEmpty) {
      return folder = folder.copyWith(folderPercent: 0);
    }
    final List<int?> averages = matchingWordsByFolderId
        .map((oneAverage) => oneAverage.average)
        .toList();
   // アベレージ計算
    final int? averagesTotal =
        averages.reduce((value, element) => value! + element!);
    final average = (averagesTotal! / averages.length).round();
    return folder = folder.copyWith(folderPercent: average);
  }).toList();
  final foldersAsyncValue = AsyncValue<List<Folder>>.data(folders);
  return AnalysisController(sqliteRepo, foldersAsyncValue);
});

class AnalysisController extends StateNotifier<AsyncValue<List<Folder>?>> {
  AnalysisController(this.sqliteRepo, this.allFolders) : super(allFolders);

  final SqliteRepository sqliteRepo;
  final AsyncValue<List<Folder>> allFolders;
}
