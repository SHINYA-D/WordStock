import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:wordstock/domain/enum/passed.dart';
import 'package:wordstock/domain/word/word.dart';
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

  Future<void> registerData(
      int cardItemCount,
      List<TextEditingController> front,
      List<TextEditingController> back,
      String folderId) async {
    for (var i = 0; i < cardItemCount; i++) {
      if ((front[i].text != "") && (back[i].text != "")) {
        final String createId = const Uuid().v4();
        Word register = Word(
          id: createId,
          frontName: front[i].text,
          backName: back[i].text,
          folderNameId: folderId,
          yesCount: 0,
          noCount: 0,
          play: 0,
          time: 0,
          percent: 0,
          average: 0,
          passed: passedJudgement(Passed.flat),
        );
        await sqliteRepo.registerWord(register);
        state = state.value != null
            ? AsyncValue.data([...state.value!, register])
            : const AsyncValue.data([]);
      }
    }
  }

  Future<void> deleteData(Word selectWord) async {
    if (selectWord.id == null) return;
    await sqliteRepo.deleteWord(selectWord.id!);
    state = state.value != null
        ? AsyncValue.data(state.value!..remove(selectWord))
        : const AsyncValue.data([]);
  }

  Future<void> upData(int index, String front, String back) async {
    if (state.value == null) return;
    state.value![index] = state.value![index].copyWith(frontName: front);
    state.value![index] = state.value![index].copyWith(backName: back);
    await sqliteRepo.upWord(state.value![index]);
    state = AsyncValue.data([...state.value!]);
  }
}
