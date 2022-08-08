// ignore_for_file: camel_case_types, invalid_annotation_target
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'word_model.freezed.dart';
part 'word_model.g.dart';

@freezed
class word_model with _$word_model {
  factory word_model({
    @JsonKey(name: 'wId') String? wId,
    @JsonKey(name: 'wFrontName') String? wFrontName,
    @JsonKey(name: 'wBackName') String? wBackName,
    @JsonKey(name: 'wTableName') String? wTableName,
    @JsonKey(name: 'wFolderNameId') String? wFolderNameId,
    @JsonKey(name: 'wYes') int? wYes,
    @JsonKey(name: 'wNo') int? wNo,
    @JsonKey(name: 'wPlay') int? wPlay,
    @JsonKey(name: 'wTime') int? wTime,
    @JsonKey(name: 'wPercent') int? wPercent,
    @JsonKey(name: 'wAverage') int? wAverage,
    @JsonKey(name: 'wOk') String? wOk,
  }) = _word_model;

  factory word_model.fromJson(Map<String, dynamic> json) =>
      _$word_modelFromJson(json);
}