import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:wordstock/model/word/word.dart';
import 'package:wordstock/pages/play_page/swipe_cards_controller.dart';
import 'package:wordstock/repository/sqlite_repository.dart';

final allWordsProvider = FutureProvider.autoDispose(
    (ref) => ref.read(sqliteRepositoryProvider).getWords());

final playsProvider = StateNotifierProvider.autoDispose<PlayPageController,
    AsyncValue<List<Word>>>((ref) {
  final sqliteRepo = ref.read(sqliteRepositoryProvider);
  final allWords = ref.watch(allWordsProvider);
  final MatchEngine matchEngine;
  allWords.value == null
      ? matchEngine = MatchEngine(swipeItems: null)
      : matchEngine = ref.watch(swipeCardsProvider(allWords));

  return PlayPageController(sqliteRepo, allWords, matchEngine);
});

class PlayPageController extends StateNotifier<AsyncValue<List<Word>>> {
  PlayPageController(this.sqliteRepo, this.allWords, this.matchEngine)
      : super(allWords);

  final SqliteRepository sqliteRepo;
  final AsyncValue<List<Word>> allWords;
  final MatchEngine matchEngine;

  get nope => matchEngine.currentItem?.nope();

  void superLike() => matchEngine.currentItem?.superLike();

  void like() => matchEngine.currentItem?.like();

  // MatchEngine? get matchEngine => state.value != null
  //     ? MatchEngine(
  //         swipeItems:
  //             state.value!.map((e) => SwipeItem(content: e.id)).toList())
  //     : null;

  Future<void> playBadUp(String upId) async {
    for (int i = 0; i < state.value!.length; i++) {
      if (state.value![i].id == upId) {
        state.value![i] =
            state.value![i].copyWith(noCount: state.value![i].noCount! + 1);
        state.value![i] =
            state.value![i].copyWith(play: state.value![i].play! + 1);
        state.value![i] = state.value![i].copyWith(ok: 'NG');
        await sqliteRepo.upWord(state.value![i]);
        state = AsyncValue.data([...state.value!]);
      }
    }
  }

  Future<void> playFlat(String folderId) async {
    final flatValue = state.value!.map((flatValue) {
      if (flatValue.folderNameId == folderId) {
        flatValue = flatValue.copyWith(ok: 'FLAT');
        sqliteRepo.upWord(flatValue);
        return flatValue;
      } else {
        return flatValue;
      }
    }).toList();
    state = AsyncValue.data([...flatValue]);
  }

  Future<void> playGoodUp(String wordId) async {
    state.value!.map((stateValue) async {
      if (stateValue.id == wordId) {
        stateValue = stateValue.copyWith(yesCount: stateValue.yesCount! + 1);
        stateValue = stateValue.copyWith(play: stateValue.play! + 1);
        stateValue = stateValue.copyWith(ok: 'OK');
        await sqliteRepo.upWord(stateValue);
        state = AsyncValue.data([...state.value!]);
      }
    });
  }
}
