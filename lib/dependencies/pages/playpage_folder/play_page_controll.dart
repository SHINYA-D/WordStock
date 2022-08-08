// ignore_for_file: non_constant_identifier_names, camel_case_types, depend_on_referenced_packages
import 'package:riverpod/riverpod.dart';
import 'package:wordstock/model/word_model/word_model.dart';
import 'package:wordstock/repository/SQLiteRepository.dart';

final startDb = FutureProvider((ref) =>
    ref.read(sqliteRepositoryProvider).getWords()
);

final playProvider = StateNotifierProvider<playPageController,
    AsyncValue<List<word_model>>> ((ref) {

  final readProvifer = ref.read(sqliteRepositoryProvider);
  final startDbs     = ref.watch(startDb);
  return playPageController(readProvifer,startDbs);

});

class playPageController extends StateNotifier<AsyncValue<List<word_model>>> {
  playPageController(this.readProvifer, this.startDbs) : super(startDbs);

  final SQLiteRepository readProvifer;
  final AsyncValue<List<word_model>> startDbs;

  //登録処理
  Future<void> controllerRegister(word_model register) async {
    await readProvifer.registerWord(register);
    state = state.value != null
        ? AsyncValue.data([...state.value!, register]) : const AsyncValue.data(
        []);
  }

  //抽出処理
  Future<void> controllerPointGet(String folderIdNum) async {
    String ng = 'NG';
    List<word_model> wordget =  await readProvifer.getPointNg(folderIdNum,ng);
    if (!mounted) return;
    state =   AsyncValue.data([...wordget]);
  }

  //Good：編集処理
  Future<void> controllerGoodUp(String upId) async {
    for (int i = 0; i < state.value!.length; i++) {
      if (state.value![i].wId == upId) {
        state.value![i] = state.value![i].copyWith(wYes: state.value![i].wYes! + 1);
        state.value![i] = state.value![i].copyWith(wPlay: state.value![i].wPlay! + 1);
        state.value![i] = state.value![i].copyWith(wOk: 'OK');
        await readProvifer.upWord(state.value![i]);
        state  = AsyncValue.data([...state.value!]);
      }
    }
  }

  //Bad：編集処理
  Future<void> controllerBadUp(String upId) async {
    for (int i = 0; i < state.value!.length; i++) {
      if (state.value![i].wId == upId) {
        state.value![i] = state.value![i].copyWith(wNo: state.value![i].wNo! + 1);
        state.value![i] = state.value![i].copyWith(wPlay: state.value![i].wPlay! + 1);
        state.value![i] = state.value![i].copyWith(wOk: 'NG');
        await readProvifer.upWord(state.value![i]);
        state  = AsyncValue.data([...state.value!]);
      }
    }
  }

  //wOkに入っている値すべてFLATに変更
  Future<void> badReset(String folderId)  async {
    for (int i = 0; i < state.value!.length; i++) {
      if (state.value![i].wFolderNameId == folderId) {
        state.value![i] = state.value![i].copyWith(wOk: 'FLAT');
        await readProvifer.upWord(state.value![i]);
        state  = AsyncValue.data([...state.value!]);
      }
    }
  }

}