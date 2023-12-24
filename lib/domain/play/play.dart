import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:wordstock/domain/word/word.dart';

part 'play.freezed.dart';

@freezed
class Play with _$Play {
  const factory Play({
    required List<SwipeItem> swipeItems,
    required MatchEngine? matchEngine,
    required List<Word> words,
  }) = _Play;

// factory User.fromJson(Map<String, dynamic> json) =>
//     _$UserFromJson(json);
}
