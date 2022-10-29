// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Folder _$$_FolderFromJson(Map<String, dynamic> json) => _$_Folder(
      id: json['id'] as String?,
      name: json['name'] as String?,
      userId: json['userId'] as String?,
      userImage: json['userImage'] as String?,
      backImage: json['backImage'] as String?,
      userName: json['userName'] as String?,
      words: (json['words'] as List<dynamic>?)
              ?.map((e) => Word.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_FolderToJson(_$_Folder instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'userId': instance.userId,
      'userImage': instance.userImage,
      'backImage': instance.backImage,
      'userName': instance.userName,
      'words': instance.words,
    };
