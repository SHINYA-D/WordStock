import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordstock/domain/enum/passed.dart';
import 'package:wordstock/domain/word/word.dart';
import 'package:wordstock/repository/sqlite_repository.dart';

final wordsProvider = FutureProvider.autoDispose.family<List<Word>, String>(
    (ref, folderId) =>
        ref.watch(sqliteRepositoryProvider).getPointWords(folderId));

final resultsProvider = StateNotifierProvider.autoDispose
    .family<PlayResultController, AsyncValue<List<Word>>, String>(
        (ref, folderId) {
  final sqliteRepo = ref.read(sqliteRepositoryProvider);
  final pointWords = ref.watch(wordsProvider(folderId));
  final folderIdNum = folderId;
  return PlayResultController(sqliteRepo, pointWords, folderIdNum);
});

class PlayResultController extends StateNotifier<AsyncValue<List<Word>>> {
  PlayResultController(
      this.sqliteRepo, AsyncValue<List<Word>> pointWords, this.folderId)
      : super(pointWords);

  final SqliteRepository sqliteRepo;
  final String folderId;

  int get bad => _badCounts();
  int get good => _goodCounts();
  int get accuracyRate {
    int goodCount = good;
    int badCount = bad;
    if (goodCount + badCount == 0) {
      // 分母が0の場合は0とするなど、適切なデフォルト値を設定
      return 0;
    }
    return ((goodCount / (goodCount + badCount)) * 100).floor();
  }
  int get total => bad + good;
  bool get visibleCheck => bad != 0 ? true : false;
  Future<List<Word>> get badReTest => sqliteRepo.getPointBad(folderId);

  Future<void> resultNextPage(BuildContext context) async {
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, "/play_page", (_) => false,
        arguments: await badReTest);
  }

  Future<void> playFlat() async {
    if (state.value == null) return;
    for (var flatValue in state.value!) {
      if (flatValue.passed == passedJudgement(Passed.good)) {
        flatValue = flatValue.copyWith(passed: 'FLAT');
        sqliteRepo.upWord(flatValue);
      }
    }
  }

  Future<void> scoreRegistration() async {
    if (state.value == null) return;
    for (var word in state.value!) {
     final yes = word.yesCount ?? 0;
     final no = word.noCount ?? 0;
     final total = yes + no;
     final average = (yes/total) * 100;
     word = word.copyWith(play: total);
     word = word.copyWith(average: average.truncate());
     await sqliteRepo.registerWord(word);
    }
  }

  int _goodCounts() {
    int count = 0;
    if (state.value == null) return 0;
    for (var value in state.value!) {
      if (value.passed == passedJudgement(Passed.good)) {
        count = count + 1;
      }
    }
    return count;
  }

  int _badCounts() {
    int count = 0;
    if (state.value == null) return 0;
    for (var value in state.value!) {
      if (value.passed == passedJudgement(Passed.bad)) {
        count = count + 1;
      }
    }
    return count;
  }
}
