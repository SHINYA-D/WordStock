import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:wordstock/domain/enum/passed.dart';
import 'package:wordstock/domain/play/play.dart';
import 'package:wordstock/domain/word/word.dart';
import 'package:wordstock/repository/sqlite_repository.dart';

part 'play_page_controller.g.dart';

@riverpod
class PlayPageController extends _$PlayPageController {
  @override
  Play build(List<Word> words) {
    final sqliteRepo = ref.read(sqliteRepositoryProvider);
    List<SwipeItem> swipeItems = [];
    List.generate(
      words.length,
      (index) => swipeItems.add(
        SwipeItem(
          content: words,
          likeAction: () {
            final words = state.words.map((word) {
              if (word.id != state.words[index].id) {
                return word;
              } else {
                return state.words[index].copyWith(
                  yesCount: state.words[index].yesCount! + 1,
                  play: state.words[index].play! + 1,
                  passed: passedJudgement(Passed.good),
                );
              }
            }).toList();
            state = state.copyWith(words: words);
            sqliteRepo.upWord(state.words[index]);
          },
          nopeAction: () {
            final words = state.words.map((word) {
              if (word.id != state.words[index].id) {
                return word;
              } else {
                return state.words[index].copyWith(
                  noCount: state.words[index].noCount! + 1,
                  play: state.words[index].play! + 1,
                  passed: passedJudgement(Passed.bad),
                );
              }
            }).toList();
            state = state.copyWith(words: words);
            sqliteRepo.upWord(state.words[index]);
          },
          superlikeAction: () {
            final words = state.words.map((word) {
              if (word.id != state.words[index].id) {
                return word;
              } else {
                return state.words[index].copyWith(
                  yesCount: state.words[index].yesCount! + 1,
                  play: state.words[index].play! + 1,
                  passed: passedJudgement(Passed.good),
                );
              }
            }).toList();
            state = state.copyWith(words: words);
            sqliteRepo.upWord(state.words[index]);
          },
        ),
      ),
    );

    final MatchEngine matchEngine = MatchEngine(swipeItems: swipeItems);

    return Play(
      swipeItems: swipeItems,
      matchEngine: matchEngine,
      words: words,
    );
  }

  void nope() {
    if (state.matchEngine == null) return;
    final sqliteRepo = ref.read(sqliteRepositoryProvider);
    final matchEngine = state.matchEngine;
    matchEngine!.currentItem?.nope();

    for (int i = 0; i < state.words.length; i++) {
      if (matchEngine.currentItem?.hashCode == state.words[i].hashCode) {
        // フラグをステイト側に付与
        state.words[i] =
            state.words[i].copyWith(passed: passedJudgement(Passed.bad));
        // バッドポイントをステイト側に付与
        state.words[i] =
            state.words[i].copyWith(noCount: state.words[i].noCount ?? 0 + 1);
        // プレイ回数を付与
        state.words[i] =
            state.words[i].copyWith(play: state.words[i].play ?? 0 + 1);
        sqliteRepo.upWord(state.words[i]);
      }
    }
  }

  void like() {
    if (state.matchEngine == null) return;
    final sqliteRepo = ref.read(sqliteRepositoryProvider);
    final matchEngine = state.matchEngine;
    matchEngine!.currentItem?.like();

    for (int i = 0; i < state.words.length; i++) {
      if (matchEngine.currentItem?.hashCode == state.words[i].hashCode) {
        // フラグをステイト側に付与
        state.words[i] =
            state.words[i].copyWith(passed: passedJudgement(Passed.good));
        // グットポイントをステイト側に付与
        state.words[i] =
            state.words[i].copyWith(yesCount: state.words[i].yesCount ?? 0 + 1);
        // プレイ回数を付与
        state.words[i] =
            state.words[i].copyWith(play: state.words[i].play ?? 0 + 1);
        sqliteRepo.upWord(state.words[i]);
      }
    }
  }
}
