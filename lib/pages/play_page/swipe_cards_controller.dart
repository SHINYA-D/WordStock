import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:wordstock/model/word/word.dart';

final swipeCardsProvider = StateNotifierProvider.family<SwipeCardsController,
    MatchEngine, AsyncValue<List<Word>>>((ref, words) {
  final swipeItems = List.generate(
    words.value!.length,
    (index) => SwipeItem(
      content: words.value![index],
    ),
  );

  final matchEngine = MatchEngine(swipeItems: swipeItems);

  return SwipeCardsController(swipeItems, matchEngine);
});

class SwipeCardsController extends StateNotifier<MatchEngine> {
  SwipeCardsController(this.swipeItems, this.matchEngine) : super(matchEngine);

  MatchEngine matchEngine;

  List<SwipeItem> swipeItems;
}
