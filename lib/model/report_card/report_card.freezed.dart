// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'report_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ReportCard _$ReportCardFromJson(Map<String, dynamic> json) {
  return _ReportCard.fromJson(json);
}

/// @nodoc
mixin _$ReportCard {
  int? get goodCount => throw _privateConstructorUsedError;
  int? get badCount => throw _privateConstructorUsedError;
  int? get accuracyRate => throw _privateConstructorUsedError;
  bool? get visible => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReportCardCopyWith<ReportCard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReportCardCopyWith<$Res> {
  factory $ReportCardCopyWith(
          ReportCard value, $Res Function(ReportCard) then) =
      _$ReportCardCopyWithImpl<$Res>;
  $Res call({int? goodCount, int? badCount, int? accuracyRate, bool? visible});
}

/// @nodoc
class _$ReportCardCopyWithImpl<$Res> implements $ReportCardCopyWith<$Res> {
  _$ReportCardCopyWithImpl(this._value, this._then);

  final ReportCard _value;
  // ignore: unused_field
  final $Res Function(ReportCard) _then;

  @override
  $Res call({
    Object? goodCount = freezed,
    Object? badCount = freezed,
    Object? accuracyRate = freezed,
    Object? visible = freezed,
  }) {
    return _then(_value.copyWith(
      goodCount: goodCount == freezed
          ? _value.goodCount
          : goodCount // ignore: cast_nullable_to_non_nullable
              as int?,
      badCount: badCount == freezed
          ? _value.badCount
          : badCount // ignore: cast_nullable_to_non_nullable
              as int?,
      accuracyRate: accuracyRate == freezed
          ? _value.accuracyRate
          : accuracyRate // ignore: cast_nullable_to_non_nullable
              as int?,
      visible: visible == freezed
          ? _value.visible
          : visible // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
abstract class _$$_ReportCardCopyWith<$Res>
    implements $ReportCardCopyWith<$Res> {
  factory _$$_ReportCardCopyWith(
          _$_ReportCard value, $Res Function(_$_ReportCard) then) =
      __$$_ReportCardCopyWithImpl<$Res>;
  @override
  $Res call({int? goodCount, int? badCount, int? accuracyRate, bool? visible});
}

/// @nodoc
class __$$_ReportCardCopyWithImpl<$Res> extends _$ReportCardCopyWithImpl<$Res>
    implements _$$_ReportCardCopyWith<$Res> {
  __$$_ReportCardCopyWithImpl(
      _$_ReportCard _value, $Res Function(_$_ReportCard) _then)
      : super(_value, (v) => _then(v as _$_ReportCard));

  @override
  _$_ReportCard get _value => super._value as _$_ReportCard;

  @override
  $Res call({
    Object? goodCount = freezed,
    Object? badCount = freezed,
    Object? accuracyRate = freezed,
    Object? visible = freezed,
  }) {
    return _then(_$_ReportCard(
      goodCount: goodCount == freezed
          ? _value.goodCount
          : goodCount // ignore: cast_nullable_to_non_nullable
              as int?,
      badCount: badCount == freezed
          ? _value.badCount
          : badCount // ignore: cast_nullable_to_non_nullable
              as int?,
      accuracyRate: accuracyRate == freezed
          ? _value.accuracyRate
          : accuracyRate // ignore: cast_nullable_to_non_nullable
              as int?,
      visible: visible == freezed
          ? _value.visible
          : visible // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ReportCard implements _ReportCard {
  _$_ReportCard(
      {this.goodCount, this.badCount, this.accuracyRate, this.visible});

  factory _$_ReportCard.fromJson(Map<String, dynamic> json) =>
      _$$_ReportCardFromJson(json);

  @override
  final int? goodCount;
  @override
  final int? badCount;
  @override
  final int? accuracyRate;
  @override
  final bool? visible;

  @override
  String toString() {
    return 'ReportCard(goodCount: $goodCount, badCount: $badCount, accuracyRate: $accuracyRate, visible: $visible)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ReportCard &&
            const DeepCollectionEquality().equals(other.goodCount, goodCount) &&
            const DeepCollectionEquality().equals(other.badCount, badCount) &&
            const DeepCollectionEquality()
                .equals(other.accuracyRate, accuracyRate) &&
            const DeepCollectionEquality().equals(other.visible, visible));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(goodCount),
      const DeepCollectionEquality().hash(badCount),
      const DeepCollectionEquality().hash(accuracyRate),
      const DeepCollectionEquality().hash(visible));

  @JsonKey(ignore: true)
  @override
  _$$_ReportCardCopyWith<_$_ReportCard> get copyWith =>
      __$$_ReportCardCopyWithImpl<_$_ReportCard>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ReportCardToJson(
      this,
    );
  }
}

abstract class _ReportCard implements ReportCard {
  factory _ReportCard(
      {final int? goodCount,
      final int? badCount,
      final int? accuracyRate,
      final bool? visible}) = _$_ReportCard;

  factory _ReportCard.fromJson(Map<String, dynamic> json) =
      _$_ReportCard.fromJson;

  @override
  int? get goodCount;
  @override
  int? get badCount;
  @override
  int? get accuracyRate;
  @override
  bool? get visible;
  @override
  @JsonKey(ignore: true)
  _$$_ReportCardCopyWith<_$_ReportCard> get copyWith =>
      throw _privateConstructorUsedError;
}
