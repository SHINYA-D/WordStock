// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ReportCard _$$_ReportCardFromJson(Map<String, dynamic> json) =>
    _$_ReportCard(
      goodCount: json['goodCount'] as int?,
      badCount: json['badCount'] as int?,
      accuracyRate: json['accuracyRate'] as int?,
      visible: json['visible'] as bool?,
    );

Map<String, dynamic> _$$_ReportCardToJson(_$_ReportCard instance) =>
    <String, dynamic>{
      'goodCount': instance.goodCount,
      'badCount': instance.badCount,
      'accuracyRate': instance.accuracyRate,
      'visible': instance.visible,
    };
