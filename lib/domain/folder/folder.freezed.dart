// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'folder.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Folder _$FolderFromJson(Map<String, dynamic> json) {
  return _Folder.fromJson(json);
}

/// @nodoc
mixin _$Folder {
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  String? get userImage => throw _privateConstructorUsedError;
  String? get backImage => throw _privateConstructorUsedError;
  String? get userName => throw _privateConstructorUsedError;
  List<Word>? get words => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FolderCopyWith<Folder> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FolderCopyWith<$Res> {
  factory $FolderCopyWith(Folder value, $Res Function(Folder) then) =
      _$FolderCopyWithImpl<$Res, Folder>;
  @useResult
  $Res call(
      {String? id,
      String? name,
      String? userId,
      String? userImage,
      String? backImage,
      String? userName,
      List<Word>? words});
}

/// @nodoc
class _$FolderCopyWithImpl<$Res, $Val extends Folder>
    implements $FolderCopyWith<$Res> {
  _$FolderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? userId = freezed,
    Object? userImage = freezed,
    Object? backImage = freezed,
    Object? userName = freezed,
    Object? words = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      userImage: freezed == userImage
          ? _value.userImage
          : userImage // ignore: cast_nullable_to_non_nullable
              as String?,
      backImage: freezed == backImage
          ? _value.backImage
          : backImage // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      words: freezed == words
          ? _value.words
          : words // ignore: cast_nullable_to_non_nullable
              as List<Word>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FolderCopyWith<$Res> implements $FolderCopyWith<$Res> {
  factory _$$_FolderCopyWith(_$_Folder value, $Res Function(_$_Folder) then) =
      __$$_FolderCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? name,
      String? userId,
      String? userImage,
      String? backImage,
      String? userName,
      List<Word>? words});
}

/// @nodoc
class __$$_FolderCopyWithImpl<$Res>
    extends _$FolderCopyWithImpl<$Res, _$_Folder>
    implements _$$_FolderCopyWith<$Res> {
  __$$_FolderCopyWithImpl(_$_Folder _value, $Res Function(_$_Folder) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? userId = freezed,
    Object? userImage = freezed,
    Object? backImage = freezed,
    Object? userName = freezed,
    Object? words = freezed,
  }) {
    return _then(_$_Folder(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      userImage: freezed == userImage
          ? _value.userImage
          : userImage // ignore: cast_nullable_to_non_nullable
              as String?,
      backImage: freezed == backImage
          ? _value.backImage
          : backImage // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      words: freezed == words
          ? _value._words
          : words // ignore: cast_nullable_to_non_nullable
              as List<Word>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Folder implements _Folder {
  _$_Folder(
      {this.id,
      this.name,
      this.userId,
      this.userImage,
      this.backImage,
      this.userName,
      final List<Word>? words = const []})
      : _words = words;

  factory _$_Folder.fromJson(Map<String, dynamic> json) =>
      _$$_FolderFromJson(json);

  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? userId;
  @override
  final String? userImage;
  @override
  final String? backImage;
  @override
  final String? userName;
  final List<Word>? _words;
  @override
  @JsonKey()
  List<Word>? get words {
    final value = _words;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Folder(id: $id, name: $name, userId: $userId, userImage: $userImage, backImage: $backImage, userName: $userName, words: $words)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Folder &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userImage, userImage) ||
                other.userImage == userImage) &&
            (identical(other.backImage, backImage) ||
                other.backImage == backImage) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            const DeepCollectionEquality().equals(other._words, _words));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, userId, userImage,
      backImage, userName, const DeepCollectionEquality().hash(_words));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FolderCopyWith<_$_Folder> get copyWith =>
      __$$_FolderCopyWithImpl<_$_Folder>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FolderToJson(
      this,
    );
  }
}

abstract class _Folder implements Folder {
  factory _Folder(
      {final String? id,
      final String? name,
      final String? userId,
      final String? userImage,
      final String? backImage,
      final String? userName,
      final List<Word>? words}) = _$_Folder;

  factory _Folder.fromJson(Map<String, dynamic> json) = _$_Folder.fromJson;

  @override
  String? get id;
  @override
  String? get name;
  @override
  String? get userId;
  @override
  String? get userImage;
  @override
  String? get backImage;
  @override
  String? get userName;
  @override
  List<Word>? get words;
  @override
  @JsonKey(ignore: true)
  _$$_FolderCopyWith<_$_Folder> get copyWith =>
      throw _privateConstructorUsedError;
}
