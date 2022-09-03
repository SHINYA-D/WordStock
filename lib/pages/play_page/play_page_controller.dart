import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:wordstock/constant/passed.dart';
import 'package:wordstock/model/word/word.dart';
import 'package:wordstock/repository/sqlite_repository.dart';

final pointWordsProvider = FutureProvider.autoDispose
    .family<List<Word>, String>((ref, folderId) =>
        ref.read(sqliteRepositoryProvider).getPointWords(folderId));

final playsProvider = StateNotifierProvider.autoDispose
    .family<PlayPageController, List<SwipeItem>, List<Word>>((ref, words) {
  final sqliteRepo = ref.read(sqliteRepositoryProvider);

  final swipeItems = List.generate(
    words.length,
    (index) => SwipeItem(
      content: words,
    ),
  );

  final matchEngine = MatchEngine(swipeItems: swipeItems);
  final pointWordProvider =
      ref.watch(pointWordsProvider(words[0].folderNameId ?? '引数が空です'));

  return PlayPageController(
      swipeItems, matchEngine, sqliteRepo, pointWordProvider);
});

class PlayPageController extends StateNotifier<List<SwipeItem>> {
  PlayPageController(
      List<SwipeItem> swipeItems, this.matchEngine, this.sqliteRepo, this.words)
      : super(swipeItems);

  final SqliteRepository sqliteRepo;

  final MatchEngine matchEngine;

  final AsyncValue<List<Word>> words;

  void nope() {
    matchEngine.currentItem?.nope();
    for (int i = 0; i < state.length; i++) {
      if (matchEngine.currentItem?.hashCode == state[i].hashCode) {
        state[i].content[i] =
            state[i].content[i].copyWith(passed: passedJudgement(Passed.bad));
        sqliteRepo.upWord(state[i].content[i]);
      }
    }
  }

  void like() {
    matchEngine.currentItem?.like();
    for (int i = 0; i < state.length; i++) {
      if (matchEngine.currentItem?.hashCode == state[i].hashCode) {
        state[i].content[i] =
            state[i].content[i].copyWith(passed: passedJudgement(Passed.good));
        sqliteRepo.upWord(state[i].content[i]);
      }
    }
  }
}
