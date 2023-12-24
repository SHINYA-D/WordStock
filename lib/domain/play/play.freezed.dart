// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'play.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Play {
  List<SwipeItem> get swipeItems => throw _privateConstructorUsedError;
  MatchEngine? get matchEngine => throw _privateConstructorUsedError;
  List<Word> get words => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PlayCopyWith<Play> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayCopyWith<$Res> {
  factory $PlayCopyWith(Play value, $Res Function(Play) then) =
      _$PlayCopyWithImpl<$Res, Play>;
  @useResult
  $Res call(
      {List<SwipeItem> swipeItems, MatchEngine? matchEngine, List<Word> words});
}

/// @nodoc
class _$PlayCopyWithImpl<$Res, $Val extends Play>
    implements $PlayCopyWith<$Res> {
  _$PlayCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? swipeItems = null,
    Object? matchEngine = freezed,
    Object? words = null,
  }) {
    return _then(_value.copyWith(
      swipeItems: null == swipeItems
          ? _value.swipeItems
          : swipeItems // ignore: cast_nullable_to_non_nullable
              as List<SwipeItem>,
      matchEngine: freezed == matchEngine
          ? _value.matchEngine
          : matchEngine // ignore: cast_nullable_to_non_nullable
              as MatchEngine?,
      words: null == words
          ? _value.words
          : words // ignore: cast_nullable_to_non_nullable
              as List<Word>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PlayCopyWith<$Res> implements $PlayCopyWith<$Res> {
  factory _$$_PlayCopyWith(_$_Play value, $Res Function(_$_Play) then) =
      __$$_PlayCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<SwipeItem> swipeItems, MatchEngine? matchEngine, List<Word> words});
}

/// @nodoc
class __$$_PlayCopyWithImpl<$Res> extends _$PlayCopyWithImpl<$Res, _$_Play>
    implements _$$_PlayCopyWith<$Res> {
  __$$_PlayCopyWithImpl(_$_Play _value, $Res Function(_$_Play) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? swipeItems = null,
    Object? matchEngine = freezed,
    Object? words = null,
  }) {
    return _then(_$_Play(
      swipeItems: null == swipeItems
          ? _value._swipeItems
          : swipeItems // ignore: cast_nullable_to_non_nullable
              as List<SwipeItem>,
      matchEngine: freezed == matchEngine
          ? _value.matchEngine
          : matchEngine // ignore: cast_nullable_to_non_nullable
              as MatchEngine?,
      words: null == words
          ? _value._words
          : words // ignore: cast_nullable_to_non_nullable
              as List<Word>,
    ));
  }
}

/// @nodoc

class _$_Play implements _Play {
  const _$_Play(
      {required final List<SwipeItem> swipeItems,
      required this.matchEngine,
      required final List<Word> words})
      : _swipeItems = swipeItems,
        _words = words;

  final List<SwipeItem> _swipeItems;
  @override
  List<SwipeItem> get swipeItems {
    if (_swipeItems is EqualUnmodifiableListView) return _swipeItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_swipeItems);
  }

  @override
  final MatchEngine? matchEngine;
  final List<Word> _words;
  @override
  List<Word> get words {
    if (_words is EqualUnmodifiableListView) return _words;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_words);
  }

  @override
  String toString() {
    return 'Play(swipeItems: $swipeItems, matchEngine: $matchEngine, words: $words)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Play &&
            const DeepCollectionEquality()
                .equals(other._swipeItems, _swipeItems) &&
            (identical(other.matchEngine, matchEngine) ||
                other.matchEngine == matchEngine) &&
            const DeepCollectionEquality().equals(other._words, _words));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_swipeItems),
      matchEngine,
      const DeepCollectionEquality().hash(_words));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PlayCopyWith<_$_Play> get copyWith =>
      __$$_PlayCopyWithImpl<_$_Play>(this, _$identity);
}

abstract class _Play implements Play {
  const factory _Play(
      {required final List<SwipeItem> swipeItems,
      required final MatchEngine? matchEngine,
      required final List<Word> words}) = _$_Play;

  @override
  List<SwipeItem> get swipeItems;
  @override
  MatchEngine? get matchEngine;
  @override
  List<Word> get words;
  @override
  @JsonKey(ignore: true)
  _$$_PlayCopyWith<_$_Play> get copyWith => throw _privateConstructorUsedError;
}
