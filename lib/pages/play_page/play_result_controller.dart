import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordstock/model/word/word.dart';
import 'package:wordstock/repository/sqlite_repository.dart';

final allWordsProvider = FutureProvider.autoDispose(
    (ref) => ref.read(sqliteRepositoryProvider).getWords());

final endProvider = StateNotifierProvider.autoDispose<PlayResultController,
    AsyncValue<List<Word>>>((ref) {
  final sqliteRepo = ref.read(sqliteRepositoryProvider);
  final allWords = ref.watch(allWordsProvider);
  return PlayResultController(sqliteRepo, allWords);
});

class PlayResultController extends StateNotifier<AsyncValue<List<Word>>> {
  PlayResultController(this.sqliteRepo, this.allWords) : super(allWords);

  final SqliteRepository sqliteRepo;
  final AsyncValue<List<Word>> allWords;

  Future<void> endBadUp(String upId) async {
    for (int i = 0; i < state.value!.length; i++) {
      if (state.value![i].wId == upId) {
        state.value![i] =
            state.value![i].copyWith(wNo: state.value![i].wNo! + 1);
        state.value![i] =
            state.value![i].copyWith(wPlay: state.value![i].wPlay! + 1);
        state.value![i] = state.value![i].copyWith(wOk: 'NG');
        await sqliteRepo.upWord(state.value![i]);
        state = AsyncValue.data([...state.value!]);
      }
    }
  }

  Future<void> endFlat(String folderId) async {
    final flatValue = state.value!.map((flatValue) {
      if (flatValue.wFolderNameId == folderId) {
        flatValue = flatValue.copyWith(wOk: 'FLAT');
        sqliteRepo.upWord(flatValue);
        return flatValue;
      } else {
        return flatValue;
      }
    }).toList();
    state = AsyncValue.data([...flatValue]);
  }
}

//TODO:成績表をグラフで表示する時に使用
// //Good：編集処理
// Future<void> endGoodUp(String upId) async {
//   for (int i = 0; i < state.value!.length; i++) {
//     if (state.value![i].wId == upId) {
//       state.value![i] =
//           state.value![i].copyWith(wYes: state.value![i].wYes! + 1);
//       state.value![i] =
//           state.value![i].copyWith(wPlay: state.value![i].wPlay! + 1);
//       state.value![i] = state.value![i].copyWith(wOk: 'OK');
//       await readProvifer.wordUp(state.value![i]);
//       state = AsyncValue.data([...state.value!]);
//     }
//   }
// }
