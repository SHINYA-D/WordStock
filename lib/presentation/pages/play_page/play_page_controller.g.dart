// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'play_page_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$playPageControllerHash() =>
    r'bc0b7ea8813e3d3de5cb4e7c3476708cec76c99d';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$PlayPageController extends BuildlessAutoDisposeNotifier<Play> {
  late final List<Word> words;

  Play build(
    List<Word> words,
  );
}

/// See also [PlayPageController].
@ProviderFor(PlayPageController)
const playPageControllerProvider = PlayPageControllerFamily();

/// See also [PlayPageController].
class PlayPageControllerFamily extends Family<Play> {
  /// See also [PlayPageController].
  const PlayPageControllerFamily();

  /// See also [PlayPageController].
  PlayPageControllerProvider call(
    List<Word> words,
  ) {
    return PlayPageControllerProvider(
      words,
    );
  }

  @override
  PlayPageControllerProvider getProviderOverride(
    covariant PlayPageControllerProvider provider,
  ) {
    return call(
      provider.words,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'playPageControllerProvider';
}

/// See also [PlayPageController].
class PlayPageControllerProvider
    extends AutoDisposeNotifierProviderImpl<PlayPageController, Play> {
  /// See also [PlayPageController].
  PlayPageControllerProvider(
    List<Word> words,
  ) : this._internal(
          () => PlayPageController()..words = words,
          from: playPageControllerProvider,
          name: r'playPageControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$playPageControllerHash,
          dependencies: PlayPageControllerFamily._dependencies,
          allTransitiveDependencies:
              PlayPageControllerFamily._allTransitiveDependencies,
          words: words,
        );

  PlayPageControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.words,
  }) : super.internal();

  final List<Word> words;

  @override
  Play runNotifierBuild(
    covariant PlayPageController notifier,
  ) {
    return notifier.build(
      words,
    );
  }

  @override
  Override overrideWith(PlayPageController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PlayPageControllerProvider._internal(
        () => create()..words = words,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        words: words,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<PlayPageController, Play> createElement() {
    return _PlayPageControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PlayPageControllerProvider && other.words == words;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, words.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PlayPageControllerRef on AutoDisposeNotifierProviderRef<Play> {
  /// The parameter `words` of this provider.
  List<Word> get words;
}

class _PlayPageControllerProviderElement
    extends AutoDisposeNotifierProviderElement<PlayPageController, Play>
    with PlayPageControllerRef {
  _PlayPageControllerProviderElement(super.provider);

  @override
  List<Word> get words => (origin as PlayPageControllerProvider).words;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
