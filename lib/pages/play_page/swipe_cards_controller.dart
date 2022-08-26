import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:wordstock/model/word/word.dart';

final swipeCardsProvider = StateNotifierProvider.family<SwipeCardsController,
    List<SwipeItem>, List<Word>>((ref, words) {
  final swipeItems = List.generate(
    words.length,
    (index) => SwipeItem(
      content: words[index],
      // likeAction: () => BotToast.showText(
      //   text: 'Liked ${words[index].text}',
      //   duration: const Duration(milliseconds: 500),
      // ),
      // nopeAction: () => BotToast.showText(
      //   text: 'Nope ${words[index].text}',
      //   duration: const Duration(milliseconds: 500),
      // ),
      // superlikeAction: () => BotToast.showText(
      //   text: 'superLike ${words[index].text}',
      //   duration: const Duration(milliseconds: 500),
      // ),
      // onSlideUpdate: (SlideRegion? region) async {
      //   if (kDebugMode) print('Region $region');
      // },
    ),
  );

  final matchEngine = MatchEngine(swipeItems: swipeItems);

  return SwipeCardsController(swipeItems, matchEngine);
});

class SwipeCardsController extends StateNotifier<List<SwipeItem>> {
  SwipeCardsController(List<SwipeItem> swipeItems, this.matchEngine)
      : super(swipeItems);

  final MatchEngine matchEngine;

  void nope() => matchEngine.currentItem?.nope();

  void superLike() => matchEngine.currentItem?.superLike();

  void like() => matchEngine.currentItem?.like();
}
