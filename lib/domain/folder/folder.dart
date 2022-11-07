import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wordstock/domain/word/word.dart';

part 'folder.freezed.dart';
part 'folder.g.dart';

@freezed
class Folder with _$Folder {
  factory Folder({
    String? id,
    String? name,
  }) = _Folder;

  factory Folder.fromJson(Map<String, dynamic> json) => _$FolderFromJson(json);
}
