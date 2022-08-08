// ignore_for_file: invalid_annotation_target, camel_case_types
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'folder_model.freezed.dart';
part 'folder_model.g.dart';

@freezed
class folder_model with _$folder_model {
  factory folder_model({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'tableName') String? tableName,
  }) = _folder_model;

  factory folder_model.fromJson(Map<String, dynamic> json) =>
      _$folder_modelFromJson(json);
}