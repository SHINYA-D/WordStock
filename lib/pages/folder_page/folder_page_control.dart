import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordstock/model/folder/folder.dart';
import 'package:wordstock/repository/sqlite_repository.dart';

final startDb =
    FutureProvider((ref) => ref.read(sqliteRepositoryProvider).getFolders());

final folderProvider =
    StateNotifierProvider<FolderPageControl, AsyncValue<List<Folder>>>((ref) {
  final readProvider = ref.read(sqliteRepositoryProvider);
  final startDbs = ref.watch(startDb);

  return FolderPageControl(readProvider, startDbs);
});

class FolderPageControl extends StateNotifier<AsyncValue<List<Folder>>> {
  FolderPageControl(this.readProvider, this.startDbs) : super(startDbs);

  final SqliteRepository readProvider;
  final AsyncValue<List<Folder>> startDbs;

  //登録処理
  Future<void> registerData(Folder register) async {
    await readProvider.registerFolder(register);
    state = state.value != null
        ? AsyncValue.data([...?state.value, register])
        : const AsyncValue.data([]);
  }

  //削除処理
  Future<void> deleteData(Folder selectFolder, int index) async {
    if (selectFolder.id != null) {
      await readProvider.deleteFolder(selectFolder.id!);
      await readProvider.deleteIdSearch(selectFolder.id!);
      state = AsyncValue.data(state.value!..remove(selectFolder));
      state = AsyncValue.data(state.value!..remove(selectFolder));
    }
  }

  //編集処理
  Future<void> upData(Folder upData) async {
    await readProvider.upFolder(upData);
    for (var i = 0; i < state.value!.length; i++) {
      if (state.value?[i].id == upData.id) {
        state.value?[i] = upData; //as AsyncValue<List<folder_model>>;
        state = AsyncValue.data([...state.value!]);
      }
    }
  }
}
