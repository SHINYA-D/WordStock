import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_card.freezed.dart';
part 'report_card.g.dart';

@freezed
class ReportCard with _$ReportCard {
  factory ReportCard({
    int? goodCount,
    int? badCount,
    int? accuracyRate,
    bool? visible,
  }) = _ReportCard;

  factory ReportCard.fromJson(Map<String, dynamic> json) =>
      _$ReportCardFromJson(json);
}
