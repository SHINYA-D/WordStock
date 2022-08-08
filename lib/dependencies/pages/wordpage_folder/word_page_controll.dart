// ignore_for_file: non_constant_identifier_names, camel_case_types, depend_on_referenced_packages
import 'package:riverpod/riverpod.dart';
import 'package:wordstock/model/word_model/word_model.dart';
import 'package:wordstock/repository/SQLiteRepository.dart';

  final startDb = FutureProvider((ref) =>
    ref.read(sqliteRepositoryProvider).getWords());

  final wordProvider = StateNotifierProvider<MainWordPageController,
    AsyncValue<List<word_model>>> ((ref) {

     final readProvifer = ref.read(sqliteRepositoryProvider);
     final startDbs     = ref.watch(startDb);
     return MainWordPageController(readProvifer,startDbs);

    });

class MainWordPageController extends
                                  StateNotifier<AsyncValue<List<word_model>>> {

  MainWordPageController(this.readProvifer, this.startDbs) : super(startDbs);

  final SQLiteRepository readProvifer;
  final AsyncValue<List<word_model>> startDbs;

  //登録処理
  Future<void> controllerRegister(word_model register) async {
    await readProvifer.registerWord(register);
    state = state.value != null
        ? AsyncValue.data([...state.value!, register]) : const AsyncValue.data(
        []);
  }

  //削除処理
  Future<void> controllerDelete(word_model selectWord) async {
    await readProvifer.deleteWord(selectWord.wId!);
    state = AsyncValue.data(state.value!..remove(selectWord));
    //..ドット2個で値を返す　カスケード
  }

  // //編集処理
  Future<void> controllerUp(word_model upData) async {
    await readProvifer.upWord(upData);
    for (var i = 0; i < state.value!.length; i++) {
      if (state.value![i].wId == upData.wId) {
        state.value![i] = upData;
        state = AsyncValue.data([...state.value!]);
      }
    }
  }

  //抽出処理
  Future<void> controllerPointGet(String forderIdNum) async {
     List<word_model> wordget =  await readProvifer.getPointWord(forderIdNum);
     if (!mounted) return;
     state =   AsyncValue.data([...wordget]);
  }
}

