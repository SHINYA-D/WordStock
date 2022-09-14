import 'package:freezed_annotation/freezed_annotation.dart';

part 'word.freezed.dart';
part 'word.g.dart';

@freezed
class Word with _$Word {
  factory Word({
    String? id,
    String? frontName,
    String? backName,
    String? folderNameId,
    int? yesCount,
    int? noCount,
    int? play,
    int? time,
    int? percent,
    int? average,
    String? passed,
  }) = _Word;

  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);
}
