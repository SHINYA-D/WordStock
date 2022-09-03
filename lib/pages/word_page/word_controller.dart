import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordstock/model/word/word.dart';
import 'package:wordstock/repository/sqlite_repository.dart';

final allWordsProvider = FutureProvider.autoDispose.family<List<Word>, String>(
    (ref, folderId) =>
        ref.read(sqliteRepositoryProvider).getPointWords(folderId));

final wordProvider = StateNotifierProvider.autoDispose
    .family<WordController, AsyncValue<List<Word>>, String>((ref, folderId) {
  final sqliteRepo = ref.read(sqliteRepositoryProvider);
  final allWords = ref.watch(allWordsProvider(folderId));
  return WordController(sqliteRepo, allWords);
});

class WordController extends StateNotifier<AsyncValue<List<Word>>> {
  WordController(this.sqliteRepo, this.allWords) : super(allWords);

  final SqliteRepository sqliteRepo;
  final AsyncValue<List<Word>> allWords;

  Future<void> registerData(Word register) async {
    await sqliteRepo.registerWord(register);
    state = state.value != null
        ? AsyncValue.data([...state.value!, register])
        : const AsyncValue.data([]);
  }

  Future<void> deleteData(Word selectWord) async {
    if (selectWord.id == null) return;
    await sqliteRepo.deleteWord(selectWord.id!);
    state = state.value != null
        ? AsyncValue.data(state.value!..remove(selectWord))
        : const AsyncValue.data([]);
  }

  Future<void> upData(Word upData) async {
    await sqliteRepo.upWord(upData);
    if (state.value == null) return;
    for (var i = 0; i < state.value!.length; i++) {
      if (state.value![i].id == upData.id) {
        state.value![i] = upData;
        state = AsyncValue.data([...state.value!]);
      }
    }
  }

  Future<void> getPointData(String? folderIdNum) async {
    List<Word> wordget;
    if (folderIdNum != null) {
      wordget = await sqliteRepo.getPointWords(folderIdNum);
      if (!mounted) return;
      state = AsyncValue.data([...wordget]);
    }
  }
}
