import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'word.freezed.dart';
part 'word.g.dart';

@freezed
class Word with _$Word {
  factory Word({
    String? wId,
    String? wFrontName,
    String? wBackName,
    String? wTableName,
    String? wFolderNameId,
    int? wYes,
    int? wNo,
    int? wPlay,
    int? wTime,
    int? wPercent,
    int? wAverage,
    String? wOk,
  }) = _Word;

  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);
}
