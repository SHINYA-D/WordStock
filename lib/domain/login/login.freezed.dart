// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'login.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Login _$LoginFromJson(Map<String, dynamic> json) {
  return _Login.fromJson(json);
}

/// @nodoc
mixin _$Login {
  String? get mail => throw _privateConstructorUsedError;
  String? get passWord => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LoginCopyWith<Login> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginCopyWith<$Res> {
  factory $LoginCopyWith(Login value, $Res Function(Login) then) =
      _$LoginCopyWithImpl<$Res>;
  $Res call({String? mail, String? passWord, String? errorMessage});
}

/// @nodoc
class _$LoginCopyWithImpl<$Res> implements $LoginCopyWith<$Res> {
  _$LoginCopyWithImpl(this._value, this._then);

  final Login _value;
  // ignore: unused_field
  final $Res Function(Login) _then;

  @override
  $Res call({
    Object? mail = freezed,
    Object? passWord = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      mail: mail == freezed
          ? _value.mail
          : mail // ignore: cast_nullable_to_non_nullable
              as String?,
      passWord: passWord == freezed
          ? _value.passWord
          : passWord // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: errorMessage == freezed
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_LoginCopyWith<$Res> implements $LoginCopyWith<$Res> {
  factory _$$_LoginCopyWith(_$_Login value, $Res Function(_$_Login) then) =
      __$$_LoginCopyWithImpl<$Res>;
  @override
  $Res call({String? mail, String? passWord, String? errorMessage});
}

/// @nodoc
class __$$_LoginCopyWithImpl<$Res> extends _$LoginCopyWithImpl<$Res>
    implements _$$_LoginCopyWith<$Res> {
  __$$_LoginCopyWithImpl(_$_Login _value, $Res Function(_$_Login) _then)
      : super(_value, (v) => _then(v as _$_Login));

  @override
  _$_Login get _value => super._value as _$_Login;

  @override
  $Res call({
    Object? mail = freezed,
    Object? passWord = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_$_Login(
      mail: mail == freezed
          ? _value.mail
          : mail // ignore: cast_nullable_to_non_nullable
              as String?,
      passWord: passWord == freezed
          ? _value.passWord
          : passWord // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: errorMessage == freezed
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Login implements _Login {
  _$_Login({this.mail, this.passWord, this.errorMessage});

  factory _$_Login.fromJson(Map<String, dynamic> json) =>
      _$$_LoginFromJson(json);

  @override
  final String? mail;
  @override
  final String? passWord;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'Login(mail: $mail, passWord: $passWord, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Login &&
            const DeepCollectionEquality().equals(other.mail, mail) &&
            const DeepCollectionEquality().equals(other.passWord, passWord) &&
            const DeepCollectionEquality()
                .equals(other.errorMessage, errorMessage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(mail),
      const DeepCollectionEquality().hash(passWord),
      const DeepCollectionEquality().hash(errorMessage));

  @JsonKey(ignore: true)
  @override
  _$$_LoginCopyWith<_$_Login> get copyWith =>
      __$$_LoginCopyWithImpl<_$_Login>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LoginToJson(
      this,
    );
  }
}

abstract class _Login implements Login {
  factory _Login(
      {final String? mail,
      final String? passWord,
      final String? errorMessage}) = _$_Login;

  factory _Login.fromJson(Map<String, dynamic> json) = _$_Login.fromJson;

  @override
  String? get mail;
  @override
  String? get passWord;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$_LoginCopyWith<_$_Login> get copyWith =>
      throw _privateConstructorUsedError;
}
