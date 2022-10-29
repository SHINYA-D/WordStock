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
  String? get userImage => throw _privateConstructorUsedError;
  String? get uid => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LoginCopyWith<Login> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginCopyWith<$Res> {
  factory $LoginCopyWith(Login value, $Res Function(Login) then) =
      _$LoginCopyWithImpl<$Res, Login>;
  @useResult
  $Res call(
      {String? mail,
      String? passWord,
      String? errorMessage,
      String? userImage,
      String? uid});
}

/// @nodoc
class _$LoginCopyWithImpl<$Res, $Val extends Login>
    implements $LoginCopyWith<$Res> {
  _$LoginCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mail = freezed,
    Object? passWord = freezed,
    Object? errorMessage = freezed,
    Object? userImage = freezed,
    Object? uid = freezed,
  }) {
    return _then(_value.copyWith(
      mail: freezed == mail
          ? _value.mail
          : mail // ignore: cast_nullable_to_non_nullable
              as String?,
      passWord: freezed == passWord
          ? _value.passWord
          : passWord // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      userImage: freezed == userImage
          ? _value.userImage
          : userImage // ignore: cast_nullable_to_non_nullable
              as String?,
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LoginCopyWith<$Res> implements $LoginCopyWith<$Res> {
  factory _$$_LoginCopyWith(_$_Login value, $Res Function(_$_Login) then) =
      __$$_LoginCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? mail,
      String? passWord,
      String? errorMessage,
      String? userImage,
      String? uid});
}

/// @nodoc
class __$$_LoginCopyWithImpl<$Res> extends _$LoginCopyWithImpl<$Res, _$_Login>
    implements _$$_LoginCopyWith<$Res> {
  __$$_LoginCopyWithImpl(_$_Login _value, $Res Function(_$_Login) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mail = freezed,
    Object? passWord = freezed,
    Object? errorMessage = freezed,
    Object? userImage = freezed,
    Object? uid = freezed,
  }) {
    return _then(_$_Login(
      mail: freezed == mail
          ? _value.mail
          : mail // ignore: cast_nullable_to_non_nullable
              as String?,
      passWord: freezed == passWord
          ? _value.passWord
          : passWord // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      userImage: freezed == userImage
          ? _value.userImage
          : userImage // ignore: cast_nullable_to_non_nullable
              as String?,
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Login implements _Login {
  _$_Login(
      {this.mail, this.passWord, this.errorMessage, this.userImage, this.uid});

  factory _$_Login.fromJson(Map<String, dynamic> json) =>
      _$$_LoginFromJson(json);

  @override
  final String? mail;
  @override
  final String? passWord;
  @override
  final String? errorMessage;
  @override
  final String? userImage;
  @override
  final String? uid;

  @override
  String toString() {
    return 'Login(mail: $mail, passWord: $passWord, errorMessage: $errorMessage, userImage: $userImage, uid: $uid)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Login &&
            (identical(other.mail, mail) || other.mail == mail) &&
            (identical(other.passWord, passWord) ||
                other.passWord == passWord) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.userImage, userImage) ||
                other.userImage == userImage) &&
            (identical(other.uid, uid) || other.uid == uid));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, mail, passWord, errorMessage, userImage, uid);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
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
      final String? errorMessage,
      final String? userImage,
      final String? uid}) = _$_Login;

  factory _Login.fromJson(Map<String, dynamic> json) = _$_Login.fromJson;

  @override
  String? get mail;
  @override
  String? get passWord;
  @override
  String? get errorMessage;
  @override
  String? get userImage;
  @override
  String? get uid;
  @override
  @JsonKey(ignore: true)
  _$$_LoginCopyWith<_$_Login> get copyWith =>
      throw _privateConstructorUsedError;
}
