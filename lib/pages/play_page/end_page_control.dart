import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordstock/model/word/word.dart';
import 'package:wordstock/repository/sqlite_repository.dart';

final startDb = FutureProvider.autoDispose(
    (ref) => ref.read(sqliteRepositoryProvider).getWords());

final endProvider =
    StateNotifierProvider.autoDispose<EndPageControl, AsyncValue<List<Word>>>(
        (ref) {
  final readProvider = ref.read(sqliteRepositoryProvider);
  final startDbs = ref.watch(startDb);
  return EndPageControl(readProvider, startDbs);
});

class EndPageControl extends StateNotifier<AsyncValue<List<Word>>> {
  EndPageControl(this.readProvider, this.startDbs) : super(startDbs);

  final SqliteRepository readProvider;
  final AsyncValue<List<Word>> startDbs;

  //Bad：編集処理
  Future<void> endBadUp(String upId) async {
    //if(state.value! == null) return ;
    for (int i = 0; i < state.value!.length; i++) {
      if (state.value![i].wId == upId) {
        state.value![i] =
            state.value![i].copyWith(wNo: state.value![i].wNo! + 1);
        state.value![i] =
            state.value![i].copyWith(wPlay: state.value![i].wPlay! + 1);
        state.value![i] = state.value![i].copyWith(wOk: 'NG');
        await readProvider.upWord(state.value![i]);
        state = AsyncValue.data([...state.value!]);
      }
    }
  }

  //wOkに入っている値すべてFLATに変更
  Future<void> endFlat(String folderId) async {
    //if(state.value! == null) return ;
    for (int i = 0; i < state.value!.length; i++) {
      if (state.value![i].wFolderNameId == folderId) {
        state.value![i] = state.value![i].copyWith(wOk: 'FLAT');
        await readProvider.upWord(state.value![i]);
        state = AsyncValue.data([...state.value!]);
      }
    }
  }
}

// 今回は使用しない為コメントアウト　・・全体グラフを作成する際に使用する
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
