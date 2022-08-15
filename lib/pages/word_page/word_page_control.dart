import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordstock/model/word/word.dart';
import 'package:wordstock/repository/sqlite_repository.dart';

final startDb =
    FutureProvider((ref) => ref.read(sqliteRepositoryProvider).getWords());

final wordProvider =
    StateNotifierProvider<WordPageControl, AsyncValue<List<Word>>>((ref) {
  final readProvider = ref.read(sqliteRepositoryProvider);
  final startDbs = ref.watch(startDb);
  return WordPageControl(readProvider, startDbs);
});

class WordPageControl extends StateNotifier<AsyncValue<List<Word>>> {
  WordPageControl(this.readProvider, this.startDbs) : super(startDbs);

  final SqliteRepository readProvider;
  final AsyncValue<List<Word>> startDbs;

  //登録処理
  Future<void> registerData(Word register) async {
    await readProvider.registerWord(register);
    state = state.value != null
        ? AsyncValue.data([...state.value!, register])
        : const AsyncValue.data([]);
  }

  //削除処理
  Future<void> deleteData(Word selectWord) async {
    await readProvider.deleteWord(selectWord.wId!);
    state = state.value != null
        ? AsyncValue.data(state.value!..remove(selectWord))
        : const AsyncValue.data([]);
  }

  // //編集処理
  Future<void> upData(Word upData) async {
    await readProvider.upWord(upData);
    //if(state.value! == null) return;
    for (var i = 0; i < state.value!.length; i++) {
      if (state.value![i].wId == upData.wId) {
        state.value![i] = upData;
        state = AsyncValue.data([...state.value!]);
      }
    }
  }

  //抽出処理
  Future<void> getPointData(String? folderIdNum) async {
    List<Word> wordget;
    if (folderIdNum != null) {
      wordget = await readProvider.getPointWords(folderIdNum);
      if (!mounted) return;
      state = AsyncValue.data([...wordget]);
    }
  }
}
