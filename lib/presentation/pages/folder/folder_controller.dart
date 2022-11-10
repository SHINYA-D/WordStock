import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordstock/domain/folder/folder.dart';
import 'package:wordstock/repository/auth_repository.dart';
import 'package:wordstock/repository/fire_repository.dart';

final allFoldersProvider = FutureProvider.family<List<Folder>, String>(
    (ref, uid) => ref.read(fireRepoProvider(uid)).getFolders());

final folderProvider = StateNotifierProvider.family<FolderController,
    AsyncValue<List<Folder>>, String>((ref, uid) {
  final fireRepo = ref.read(fireRepoProvider(uid));
  final allFolders = ref.watch(allFoldersProvider(uid));
  final authRepo = ref.watch(authRepoProvider);

  return FolderController(fireRepo, allFolders, authRepo);
});

class FolderController extends StateNotifier<AsyncValue<List<Folder>>> {
  FolderController(this.fireRepo, this.allFolders, this.auths)
      : super(allFolders);

  final FireRepository fireRepo;
  final AsyncValue<List<Folder>> allFolders;
  final AuthRepository auths;

  Future<void> registerData(Folder register) async {
    await fireRepo.registerFolder(register);
    state = state.value != null
        ? AsyncValue.data([...?state.value, register])
        : const AsyncValue.data([]);
  }

  Future<void> deleteData(Folder folder, int index) async {
    await fireRepo.deleteFolder(folder);
    //TODO:フォルダに紐づいているワードも削除するコードだったがfirebaseはいらないかも
    //await fireRepo.deleteIdSearch(selectFolder.id);
    if (state.value == null) return;
    state = AsyncValue.data(state.value!..remove(folder));
  }

  Future<void> upData(int index, String dataText) async {
    if (state.value == null) return;
    state.value![index] = state.value![index].copyWith(name: dataText);
    await fireRepo.updateFolder(state.value![index]);
    state = AsyncValue.data([...state.value!]);
  }
}
