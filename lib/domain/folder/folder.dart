// ignore_for_file: invalid_annotation_target
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wordstock/domain/word/word.dart';

part 'folder.freezed.dart';
part 'folder.g.dart';

@freezed
class Folder with _$Folder {
  factory Folder({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'name') String? name,
    @Default(0)@JsonKey(name: 'folderPercent') int folderPercent,
    @JsonKey(ignore: true) @Default([]) List<Word>? words,
  }) = _Folder;

  factory Folder.fromJson(Map<String, dynamic> json) => _$FolderFromJson(json);
}
