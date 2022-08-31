import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordstock/model/report_card/report_card.dart';
import 'package:wordstock/model/word/word.dart';
import 'package:wordstock/repository/sqlite_repository.dart';

final reportProvider = FutureProvider.autoDispose.family<ReportCard, String>(
    (ref, folderId) =>
        ref.watch(sqliteRepositoryProvider).getReportCard(folderId));

final resultsProvider = StateNotifierProvider.autoDispose
    .family<PlayResultController, AsyncValue<ReportCard>, String>(
        (ref, folderId) {
  final sqliteRepo = ref.read(sqliteRepositoryProvider);
  final reportCards = ref.watch(reportProvider(folderId));
  final String folderIdNum = folderId;
  return PlayResultController(sqliteRepo, reportCards, folderIdNum);
});

class PlayResultController extends StateNotifier<AsyncValue<ReportCard>> {
  PlayResultController(
      this.sqliteRepo, AsyncValue<ReportCard> pointWords, this.folderId)
      : super(pointWords);

  final SqliteRepository sqliteRepo;
  //final AsyncValue<ReportCard> pointWords;
  final String folderId;

  get getBadPoint => sqliteRepo.getPointNg(folderId);

  Future<void> resultFlat(String folderId) async {
    List<Word> getPointWord = await sqliteRepo.getPointWords(folderId);
    getPointWord.map((goodPoint) {
      goodPoint = goodPoint.copyWith(ok: 'FLAT');
      sqliteRepo.upWord(goodPoint);
    }).toList();
  }
}
