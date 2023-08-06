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
    int? yesCount,//変動
    int? noCount,//変動
    int? play,//変動
    int? time,
    int? percent,//変動・正解率(使用していないです)
    int? average,//変動・正解率
    String? passed,//変動
  }) = _Word;

  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);
}
