// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'top_up.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TopUp {
  int get value => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TopUpCopyWith<TopUp> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TopUpCopyWith<$Res> {
  factory $TopUpCopyWith(TopUp value, $Res Function(TopUp) then) =
      _$TopUpCopyWithImpl<$Res, TopUp>;
  @useResult
  $Res call({int value, String label});
}

/// @nodoc
class _$TopUpCopyWithImpl<$Res, $Val extends TopUp>
    implements $TopUpCopyWith<$Res> {
  _$TopUpCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? label = null,
  }) {
    return _then(_value.copyWith(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TopUpImplCopyWith<$Res> implements $TopUpCopyWith<$Res> {
  factory _$$TopUpImplCopyWith(
          _$TopUpImpl value, $Res Function(_$TopUpImpl) then) =
      __$$TopUpImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int value, String label});
}

/// @nodoc
class __$$TopUpImplCopyWithImpl<$Res>
    extends _$TopUpCopyWithImpl<$Res, _$TopUpImpl>
    implements _$$TopUpImplCopyWith<$Res> {
  __$$TopUpImplCopyWithImpl(
      _$TopUpImpl _value, $Res Function(_$TopUpImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? label = null,
  }) {
    return _then(_$TopUpImpl(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TopUpImpl implements _TopUp {
  const _$TopUpImpl({required this.value, required this.label});

  @override
  final int value;
  @override
  final String label;

  @override
  String toString() {
    return 'TopUp(value: $value, label: $label)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TopUpImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.label, label) || other.label == label));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value, label);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TopUpImplCopyWith<_$TopUpImpl> get copyWith =>
      __$$TopUpImplCopyWithImpl<_$TopUpImpl>(this, _$identity);
}

abstract class _TopUp implements TopUp {
  const factory _TopUp(
      {required final int value, required final String label}) = _$TopUpImpl;

  @override
  int get value;
  @override
  String get label;
  @override
  @JsonKey(ignore: true)
  _$$TopUpImplCopyWith<_$TopUpImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
