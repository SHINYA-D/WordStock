// ignore_for_file: non_constant_identifier_names, camel_case_types, depend_on_referenced_packages
import 'package:riverpod/riverpod.dart';
import 'package:wordstock/model/folder_model/folder_model.dart';
import 'package:wordstock/repository/SQLiteRepository.dart';

final startDb = FutureProvider((ref) =>
    ref.read(sqliteRepositoryProvider).getFolders());

final folderProvider = StateNotifierProvider<MainFolderPageController,
    AsyncValue<List<folder_model>>> ((ref) {

      final readProvifer = ref.read(sqliteRepositoryProvider);
      final startDbs     = ref.watch(startDb);
      return MainFolderPageController(readProvifer,startDbs);

    });

class MainFolderPageController extends
                                 StateNotifier<AsyncValue<List<folder_model>>> {

  MainFolderPageController(this.readProvifer, this.startDbs) : super(startDbs);

  final SQLiteRepository readProvifer;
  final AsyncValue<List<folder_model>> startDbs;

  //登録処理
  Future<void> controllerRegister(folder_model register) async {
    await readProvifer.registerFolder(register);
    state = state.value != null
        ? AsyncValue.data([...state.value!, register]) : const AsyncValue.data(
        []);
  }

  //削除処理
  Future<void> controllerDelete(folder_model selectFolder) async {
    await readProvifer.deleteFolder(selectFolder.id!);
    await readProvifer.deleteFolderWord(selectFolder.id!);
    state = AsyncValue.data(state.value!..remove(selectFolder));
  }

  // //編集処理
  Future<void> controllerUp(folder_model upData) async {
    await readProvifer.upFolder(upData);
    for (var i = 0; i < state.value!.length; i++) {
      if (state.value![i].id == upData.id) {
       state.value![i] = upData; //as AsyncValue<List<folder_model>>;
       state = AsyncValue.data([...state.value!]);
      }
    }
  }
}

