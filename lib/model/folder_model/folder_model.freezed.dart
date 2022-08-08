// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'folder_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

folder_model _$folder_modelFromJson(Map<String, dynamic> json) {
  return _folder_model.fromJson(json);
}

/// @nodoc
mixin _$folder_model {
  @JsonKey(name: 'id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'tableName')
  String? get tableName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $folder_modelCopyWith<folder_model> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $folder_modelCopyWith<$Res> {
  factory $folder_modelCopyWith(
          folder_model value, $Res Function(folder_model) then) =
      _$folder_modelCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'tableName') String? tableName});
}

/// @nodoc
class _$folder_modelCopyWithImpl<$Res> implements $folder_modelCopyWith<$Res> {
  _$folder_modelCopyWithImpl(this._value, this._then);

  final folder_model _value;
  // ignore: unused_field
  final $Res Function(folder_model) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? tableName = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      tableName: tableName == freezed
          ? _value.tableName
          : tableName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_folder_modelCopyWith<$Res>
    implements $folder_modelCopyWith<$Res> {
  factory _$$_folder_modelCopyWith(
          _$_folder_model value, $Res Function(_$_folder_model) then) =
      __$$_folder_modelCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'tableName') String? tableName});
}

/// @nodoc
class __$$_folder_modelCopyWithImpl<$Res>
    extends _$folder_modelCopyWithImpl<$Res>
    implements _$$_folder_modelCopyWith<$Res> {
  __$$_folder_modelCopyWithImpl(
      _$_folder_model _value, $Res Function(_$_folder_model) _then)
      : super(_value, (v) => _then(v as _$_folder_model));

  @override
  _$_folder_model get _value => super._value as _$_folder_model;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? tableName = freezed,
  }) {
    return _then(_$_folder_model(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      tableName: tableName == freezed
          ? _value.tableName
          : tableName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_folder_model with DiagnosticableTreeMixin implements _folder_model {
  _$_folder_model(
      {@JsonKey(name: 'id') this.id,
      @JsonKey(name: 'name') this.name,
      @JsonKey(name: 'tableName') this.tableName});

  factory _$_folder_model.fromJson(Map<String, dynamic> json) =>
      _$$_folder_modelFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String? id;
  @override
  @JsonKey(name: 'name')
  final String? name;
  @override
  @JsonKey(name: 'tableName')
  final String? tableName;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'folder_model(id: $id, name: $name, tableName: $tableName)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'folder_model'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('tableName', tableName));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_folder_model &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.tableName, tableName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(tableName));

  @JsonKey(ignore: true)
  @override
  _$$_folder_modelCopyWith<_$_folder_model> get copyWith =>
      __$$_folder_modelCopyWithImpl<_$_folder_model>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_folder_modelToJson(
      this,
    );
  }
}

abstract class _folder_model implements folder_model {
  factory _folder_model(
      {@JsonKey(name: 'id') final String? id,
      @JsonKey(name: 'name') final String? name,
      @JsonKey(name: 'tableName') final String? tableName}) = _$_folder_model;

  factory _folder_model.fromJson(Map<String, dynamic> json) =
      _$_folder_model.fromJson;

  @override
  @JsonKey(name: 'id')
  String? get id;
  @override
  @JsonKey(name: 'name')
  String? get name;
  @override
  @JsonKey(name: 'tableName')
  String? get tableName;
  @override
  @JsonKey(ignore: true)
  _$$_folder_modelCopyWith<_$_folder_model> get copyWith =>
      throw _privateConstructorUsedError;
}
