// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Folder _$$_FolderFromJson(Map<String, dynamic> json) => _$_Folder(
      id: json['id'] as String?,
      name: json['name'] as String?,
      folderPercent: json['folderPercent'] as int? ?? 0,
      words: (json['words'] as List<dynamic>?)
              ?.map((e) => Word.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_FolderToJson(_$_Folder instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'folderPercent': instance.folderPercent,
      'words': instance.words,
    };
